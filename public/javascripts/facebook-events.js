var EventListener = function () {
  var boundEvents = {};

  return {
    bind: function (name, fn) {
      boundEvents[name] = boundEvents[name] || [];
      boundEvents[name].push(fn);
    },
    trigger: function (name, params) {
      if (boundEvents[name]) {
        $.each(boundEvents[name], function (i, fn) {
          fn(params);
        });
      };
    }
  };
}

var FacebookApi = function () {
  var self = {};
  self = $.extend(self, new EventListener());
  var permissions = []

  self.initialize = function () {
    window.fbAsyncInit = function () {
      FB.init({ appId: FacebookConfig.appId, status: true, cookie: false, xfbml: false });
      self.trigger("initialized");
    }
    $('<div id="fb-root"></div>').appendTo("body");
    $('<script src="http://connect.facebook.net/en_US/all.js" async></script>').appendTo("body");
  };

  self.requirePermission = function (name) {
    permissions.push(name);
  }

  var getPermissionsString = function () {
    return permissions.sort().join(",");
  }

  self.login = function (success, failure) {
    FB.login(function (response) {
      if (response.session && response.perms) {
        success();
      } else {
        failure();
      }
    }, { perms: getPermissionsString() });
  }

  self.getLoginStatus = function (success, failure) {
    FB.getLoginStatus(function(response) {
      if (response.session) {
        success();
      } else {
        failure();
      }
    });
  }

  self.loginOrGetStatus = function (success, failure) {
    self.getLoginStatus(success, function () {
      self.login(success, failure);
    });
  }

  self.getAttendanceStatus = function (eventId, callback) {
    FB.api("/me/events", function (response) {
      var status;
      if (response.data) {
        $.each(response.data, function (i, event) {
          if (event.id == eventId) status = event.rsvp_status;
        })
      }
      callback(status);
    });
  }

  self.attendEvent = function (eventId, callback) {
    FB.api("/" + eventId + "/attending", "post", callback);
  }

  self.declineEvent = function (eventId, callback) {
    FB.api("/" + eventId + "/declined", "post", callback);
  }

  return self;
};

var FacebookEventWidget = function (model, view) {
  var self = {};

  self.initialize = function () {
    view.bind("attend-clicked", model.attend);
    view.bind("decline-clicked", model.decline);
    view.initialize();
    model.bind("attendants-loaded", view.showAttendants);
    model.bind("my-attendance-loaded", view.showMyAttendance);
    model.bind("login-failed", view.loginFailed);
    model.loadAttendants();
    model.loadMyAttendance();
  }

  return self;
};

var FacebookEvent = function (facebookApi, params) {
  var self = {};
  self = $.extend(self, new EventListener());

  facebookApi.requirePermission("rsvp_event");
  facebookApi.requirePermission("user_events");

  self.loadAttendants = function () {
    $.get(params.attendantsUrl, function (response) {
      self.trigger("attendants-loaded", response);
    })
  };

  self.loadMyAttendance = function () {
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
      function onFailure () { }
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
  self = $.extend(self, new EventListener());

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

  self.showMyAttendance = function (status) {
    $(elem).find(".attendants a.attend")[status ? "hide" : "show"]();
    $(elem).find(".attendants a.decline")[status ? "show" : "hide"]();
  }

  self.loginFailed = function () {
    alert("Musisz sie zalogowac.");
  }

  return self;
};

$(document).ready(function () {
  var facebookApi = new FacebookApi();
  var facebookEvents = $(".event.facebook");
  if (facebookEvents.length > 0) {
    facebookApi.bind("initialized", function () {
      facebookEvents.each(function () {
        var model = new FacebookEvent(facebookApi, {
          facebookId: $(this).data("facebook-id"),
          attendantsUrl: $(this).data("attendants-url")
        });
        var view = new FacebookEventView(this);
        var widget = new FacebookEventWidget(model, view);
        widget.initialize();
      });
    });
    facebookApi.initialize();
  }
});
