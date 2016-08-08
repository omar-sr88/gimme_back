var ready = function() {
  $("#go-login").click(function () {
        //$('.login-form').show();
        //$('.signup-form').hide();
  });  

  $("#go-signup").click(function () {
       // $('.login-form').hide();
       // $('.signup-form').show();
  });  

};

$(document).on('turbolinks:load', ready);