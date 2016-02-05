$(document).ready(function() {

  $(".bid-now-button").click(function(e) {
    e.preventDefault();
      $('.form').show();
      $(".bid-now-button").hide();
      $('.submit-bid-button').addClass("styled-bid-button");
      $('.bid-form').addClass("styled");

    // $(this).unbind();

  });


  $('.text .bid-now-button').click(function(e) {
    e.preventDefault();
    alert("Please sign in!");
  });

});
