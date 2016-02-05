$(document).ready(function() {

  $('.form .bid-now-button').click(function(e) {
    e.preventDefault();
    $('.bid-form').addClass("styled");
    $('.bid-now-button').addClass("styled-bid-button");

    $(this).unbind();
  });

  $('.text .bid-now-button').click(function(e) {
    e.preventDefault();
    alert("Please sign in!");
  });

});
