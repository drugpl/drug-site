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

  self.initialize = function () {
    window.fbAsyncInit = function () {
      FB.init({ appId: FacebookConfig.appId, status: true, cookie: false, xfbml: false });
      self.trigger("initialized");
    }
    $('<div id="fb-root"></div>').appendTo("body");
    $('<script src="http://connect.facebook.net/en_US/all.js" async></script>').appendTo("body");
  };

  return self;
};

var FacebookEventWidget = function (model, view) {
  view.resetAttendants();
  model.bind("attendant-loaded", view.addAttendant);
  model.load();
}

var FacebookEvent = function (id) {
  var self = {};
  self = $.extend(self, new EventListener());
  self.load = function () {
    var query = '\
      SELECT uid, name, pic_square, profile_url \
      FROM user \
      WHERE uid IN ( \
        SELECT uid FROM event_member WHERE eid="' + id + '" AND rsvp_status="attending" \
      )\
    ';
    FB.api({ method: 'fql.query', query: query, access_token: FacebookConfig.token }, function (response) {
      if (typeof response.error_code === "undefined") {
        $.each(response, function (i, person) {
          self.trigger("attendant-loaded", person);
        });
      }
    });
  };
  return self;
};

var FacebookEventView = function (elem) {
  var self = {};
  self.resetAttendants = function () {
    $(elem).find(".attendants ul").remove();
    $(elem).find(".attendants").append('<ul></ul>');
  }
  self.addAttendant = function (person) {
    var html = '<li><img src="'+person.pic_square+'" alt="'+person.name+'" /></li>';
    var li = $(html).appendTo($(elem).find(".attendants ul"));
    if (person.profile_url) {
      li.wrapInner('<a href="'+person.profile_url+'" title="'+person.name+'"></a>')
    }
  }
  return self;
};

$(document).ready(function () {
  var facebookApi = new FacebookApi();

  var facebookEvents = $(".event[data-facebook-id]");
  if (facebookEvents.length > 0) {
    facebookApi.bind("initialized", function () {
      facebookEvents.each(function () {
        var id = $(this).data("facebook-id");
        new FacebookEventWidget(new FacebookEvent(id), new FacebookEventView(this));
      });
    });
    facebookApi.initialize();
  }
});
