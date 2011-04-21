var FacebookEventWidget = function (model, view) {
  var self = {};

  self.initialize = function () {
    view.bind("attend-clicked", model.attend);
    view.bind("decline-clicked", model.decline);
    view.initialize();
    model.bind("attendants-loading", view.onAttendantsLoading);
    model.bind("attendants-loaded", view.showAttendants);
    model.bind("my-attendance-loading", view.onMyAttendanceLoading);
    model.bind("my-attendance-loaded", view.showMyAttendance);
    model.bind("login-failed", view.loginFailed);
    model.loadAttendants();
    model.loadMyAttendance();
  }

  return self;
};

var FacebookEvent = function (facebookApi, params) {
  var self = {};
  self = $.extend(self, new Observable());

  facebookApi.requirePermission("rsvp_event");
  facebookApi.requirePermission("user_events");

  self.loadAttendants = function () {
    self.trigger("attendants-loading");
    $.get(params.attendantsUrl, function (response) {
      self.trigger("attendants-loaded", response);
    })
  };

  self.loadMyAttendance = function () {
    self.trigger("my-attendance-loading");
    facebookApi.getLoginStatus(
      function onSuccess () {
        facebookApi.getAttendanceStatus(params.facebookId, function (result) {
          if (result === "attending") {
            self.trigger("my-attendance-loaded", true);
          } else if (result === "declined") {
            self.trigger("my-attendance-loaded", false);
          } else {
            self.trigger("my-attendance-loaded", undefined);
          }
        });
      },
      function onFailure () {
        self.trigger("my-attendance-loaded", undefined);
      }
    )
  };

  self.attend = function () {
    facebookApi.loginOrGetStatus(
      function onSuccess () {
        facebookApi.attendEvent(params.facebookId, function () {
          self.loadAttendants();
          self.loadMyAttendance();
        });
      },
      function onFailure () {
        self.trigger("login-failed");
      }
    );
  };

  self.decline = function () {
    facebookApi.loginOrGetStatus(
      function onSuccess () {
        facebookApi.declineEvent(params.facebookId, function () {
          self.loadAttendants();
          self.loadMyAttendance();
        });
      },
      function onFailure () { }
    );
  }

  return self;
};

var FacebookEventView = function (elem) {
  var self = {};
  self = $.extend(self, new Observable());

  self.initialize = function () {
    $(elem).find(".attendants a.attend").click(function () {
      self.trigger("attend-clicked");
      return false;
    });
    $(elem).find(".attendants a.decline").hide().click(function () {
      self.trigger("decline-clicked");
      return false;
    });
    $(elem).find(".attendants").append('<ul></ul>');
  }

  self.showAttendants = function (people) {
    var resetAttendants = function () {
      $(elem).find(".attendants ul").empty();
    }
    var showPerson = function (person) {
      var html = '<li><img src="'+person.pic_square+'" alt="'+person.name+'" /></li>';
      var li = $(html).appendTo($(elem).find(".attendants ul"));
      if (person.profile_url) {
        li.wrapInner('<a href="'+person.profile_url+'" title="'+person.name+'"></a>')
      }
    }
    resetAttendants();
    $.each(people, function (i, person) { showPerson(person) });
  }

  self.onAttendantsLoading = function () {
    $(elem).find(".attendants ul").empty();
    $(elem).find(".attendants ul").append('<li><img src="/images/throbber.gif" alt="..." class="throbber" /></li>');
  }

  self.showMyAttendance = function (status) {
    $(elem).find("p.attendance").find("img.throbber").remove();
    $(elem).find("p.attendance a.attend")[status ? "hide" : "show"]();
    $(elem).find("p.attendance a.decline")[status ? "show" : "hide"]();
  }

  self.onMyAttendanceLoading = function () {
    var img = '<img src="/images/throbber.gif" alt="..." class="throbber" />'
    $(elem).find("p.attendance").find("img.throbber").remove();
    $(elem).find("p.attendance a").hide();
    $(elem).find("p.attendance").append(img);
  }

  self.loginFailed = function () {
    alert("Musisz sie zalogowac.");
  }

  return self;
};

var FacebookApplication = function () {
  var self = {};
  var facebookApi = new FacebookApi();

  self.initialize = function () {
    if (self.hasFacebookWigets()) {
      facebookApi.bind("initialized", function () {
        self.createEventWidgets();
      });
      facebookApi.initialize();
    }
  };

  self.hasFacebookWigets = function () {
    return $(".event.facebook").length > 0;
  }

  self.createEventWidgets = function () {
    $(".event.facebook").each(function () {
      self.createEventWidget($(this));
    })
  };

  self.createEventWidget = function (elem) {
    var model = new FacebookEvent(facebookApi, {
      facebookId: elem.data("facebook-id"),
      attendantsUrl: elem.data("attendants-url")
    });
    var view = new FacebookEventView(elem);
    var widget = new FacebookEventWidget(model, view);
    widget.initialize();
  };

  return self;
};

$(document).ready(function () {
  var app = new FacebookApplication();
  app.initialize();
});
