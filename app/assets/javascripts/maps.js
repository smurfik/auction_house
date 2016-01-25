var map;
$(function() {

  if (navigator === undefined) {
    initializeMap(-34.1, 150.6);
  } else {

  navigator.geolocation.getCurrentPosition(function(position){
    var lat = position.coords.latitude;
    var lng = position.coords.longitude;
    initializeMap(lat,lng);
    });
  }

  var initializeMap = (function(lat,lng) {
    var mapDiv = $("#map")[0];
    var map = new google.maps.Map(mapDiv, {
      center: {lat: lat, lng: lng},
      zoom: 13
      });
  });

});
