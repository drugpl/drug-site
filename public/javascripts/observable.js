var Observable = function () {
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
