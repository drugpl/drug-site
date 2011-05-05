$(document).ready(function() {
  var polish_time_formatter = function(time) {
    var r;
    var pluralize = function (count, one, few, many) {
      if (count == 1) {
        return one;
      } else if ((count < 10 || count > 20) && (count % 10 > 1) && (count % 10 < 5)) {
        return count + " " + few;
      } else {
        return count + " " + many;
      }
    }
    if (time.seconds) {
      r = pluralize(time.seconds, "sekundę", "sekundy", "sekund");
    } else if (time.minutes) {
      r = pluralize(time.minutes, "minutę", "minuty", "minut");
    } else if (time.hours) {
      r = pluralize(time.hours, "godzinę", "godziny", "godzin");
    } else if (time.days) {
      r = pluralize(time.days, "1 dzień", "dni", "dni");
    }
    return r + ' temu';
  };

  $('#twitter-feed').each(function () {
    $(this).tweet({
      username: $(this).data("user"),
      list: $(this).data("list"),
      avatar_size: 32,
      count: 3,
      loading_text: "...",
      template: "{avatar}{user} {text} {time}",
      relative_time_formatter: polish_time_formatter
    });
  });
});
