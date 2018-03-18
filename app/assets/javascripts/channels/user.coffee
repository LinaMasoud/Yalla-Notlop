App.user = App.cable.subscriptions.create "UserChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    $("#notifi").append("<p>"+data.data.msg+"</p>"+"<button id='"+data.data.order+"' onclick='joinOrder(this)'>Join</button>"+"<button onclick='cancel(this)'>Cancel</button>")


