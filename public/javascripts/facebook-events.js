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

var FacebookEventWidget = function (model, view) {
  return {
    initialize: function () {
      view.resetAttendants();
      model.bind("attendant-loaded", view.addAttendant);
      model.load();
    }
  };
};

var FacebookEvent = function (url) {
  var self = {};
  self = $.extend(self, new EventListener());
  self.load = function () {
    $.get(url, function (response) {
      $.each(response, function (i, person) {
        self.trigger("attendant-loaded", person);
      });
    })
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
  var facebookEvents = $(".event[data-attendants-url]");
  if (facebookEvents.length > 0) {
    facebookEvents.each(function () {
      var url = $(this).data("attendants-url");
      var widget = new FacebookEventWidget(new FacebookEvent(url), new FacebookEventView(this));
      widget.initialize();
    });
  }
});
