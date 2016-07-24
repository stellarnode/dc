
document.addEventListener("DOMSubtreeModified", function(event) {

  var loc = location.pathname;

  if (/chat_message/i.test(loc)) {

    function updateScroll(element) {
      element.scrollTop = element.scrollHeight;
    }

    var element = document.getElementById("message_view");
    var messageSubmit = document.getElementById("message_submit");
    var messageForm = document.getElementById("message_form");
    var newMessage = document.querySelector("new_chat_message");

    updateScroll(element);

    element.addEventListener("DOMSubtreeModified", function() {
      updateScroll(element)
    });

    $(".new_chat_message").bind("ajax:complete", function(e) {
      messageForm.value = "";
    });

  }

});
