$(document).ready ->
  $(".mark_all_as_done").click (e)->
    e.preventDefault();
    $(this).
      parent().
      parent().
      children("section").
      children("div").
      children("select").
      val("done");
    