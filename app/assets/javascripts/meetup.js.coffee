$(document).ready ->
  $("#speak").click ->
    $('#myModal').modal('show')

  $("#speak-submit").click ->
    $.ajax(
      type: 'post'
      url: $("#new_presentation").attr('action')
      data: $("#new_presentation").serialize()
      dataType: 'json'
      success: (data) ->
        $(".alerts").append(
          alert.success('Twoja prezentacja została dodana')
        )
        $('#myModal').modal('toggle')
    )

  $('.sign-in-button').click (event)->
    event.preventDefault()
    $(".sign-in").dialog({
      modal: true
    })

  $('.sign-in').hide()