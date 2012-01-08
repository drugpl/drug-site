var FacebookApi = function () {
  var self = {};
  self = $.extend(self, new Observable());
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
      if (response.status === 'connected') {
        success();
      } else {
        failure();
      }
    }, { scope: getPermissionsString() });
  }

  self.getLoginStatus = function (success, failure) {
    FB.getLoginStatus(function(response) {
      if (response.status === 'connected') {
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
