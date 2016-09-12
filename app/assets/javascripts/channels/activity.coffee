App.activity = App.cable.subscriptions.create "ActivityChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Receives the rendered li item, pushes it. Adds one to unseen counter
    $('.dropdown-menu.message-dropdown').prepend data['notification']
    prevCount = parseInt($('.badge.badge-notify').text(),10) || 0;
    $('.badge.badge-notify').text(prevCount+1)
    
  notify: (message) ->
    @perform 'notify', message: message