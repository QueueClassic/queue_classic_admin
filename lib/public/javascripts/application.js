$(document).ready(function(){
  $("form[data-confirm]").submit(function(event) {
    var message;
    message = $(this).attr('data-confirm');
    if (confirm(message)) {
      return true;
    } else {
      event.preventDefault();
      return false;
    }
  });
});
