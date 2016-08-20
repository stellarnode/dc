App.chat = App.cable.subscriptions.create({channel: "ChatChannel", room: "chat"}, {
  connected: function() {
    // Called when the subscription is ready for use on the server
    console.log("websocket connected...");
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
    console.log("websocket disconnected...");
  },

  received: function(data) {
    // Called when there's incoming data on the websocket for this channel
    console.log("received data...");
    // console.log(data);
    // console.log(document.cookie);
    var messages = document.getElementById("list_of_messages");
    var newMessage = document.createElement("p");
    var cookies = document.cookie.split(";");
    var cls = "";
    cookies.forEach(function(el) {
      if (/user_email/i.test(el)) {
        var email = el.split("=");
        email = decodeURIComponent(email[1]);
        if (email === data.user) {
            cls = "current_user";
        }
      }
    });
    newMessage.innerHTML = "<strong " + "class=\"" + cls + "\">" + data.user + ": </strong>" + data.message;
    messages.appendChild(newMessage);
  },

});
