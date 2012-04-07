class Alert
  alert: (type, message) ->
    "<div class='alert alert-#{type}'>
      <a class='close' data-dismiss='alert'>×</a>
      <strong>#{message}</strong>
    </div>"

  error: (message) ->
    this.alert('error', message)

  success: (message) ->
    this.alert('success', message)

  info: (message) ->
    this.alert('info', message)


window.alert = new Alert