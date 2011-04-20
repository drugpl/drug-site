$(document).ready(function() {
  $('#twitter-feed').each(function () {
    $(this).tweet({
      username: $(this).data("user"),
      list: $(this).data("list"),
      avatar_size: 32,
      count: 3,
      loading_text: "...",
      template: "{avatar}{user} {text} {time}"
    });
  });
});
