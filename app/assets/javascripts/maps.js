var currentLocation;
var map;

navigator.geolocation.getCurrentPosition(function(position){
  var lat = position.coords.latitude;
  var lng = position.coords.longitude;
  map.setCenter({lat: lat, lng: lng});
  });

function initialize() {

  var markers = [];
    map = new google.maps.Map(document.getElementById('map-canvas'), {
    mapTypeId: google.maps.MapTypeId.ROADMAP
  });

  var defaultBounds = new google.maps.LatLngBounds(
      new google.maps.LatLng(47.5635, -122.4224),
      new google.maps.LatLng(47.7074, -122.2631));
  map.fitBounds(defaultBounds);

  // Create the search box and link it to the UI element.
  var input = document.getElementById('pac-input');
  map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);

  var searchBox = new google.maps.places.SearchBox(input, {
    bounds: defaultBounds});

  // [START region_getplaces]
  // Listen for the event fired when the user selects an item from the
  // pick list. Retrieve the matching places for that item.
  google.maps.event.addListener(searchBox, 'places_changed', function() {

    $.get( "/house", function( data ) {
      $(".property-details").html( data );
    });

    var places = searchBox.getPlaces();

    if (places.length === 0) {
      return;
    } for (var i = 0, marker; marker = markers[i]; i++) {
      marker.setMap(null);
    }

    // For each place, get the icon, place name, and location.
    markers = [];
    var bounds = new google.maps.LatLngBounds();
    for (var i = 0, place; place = places[i]; i++) {
      var image = {
        url: place.icon,
        size: new google.maps.Size(71, 71),
        origin: new google.maps.Point(0, 0),
        anchor: new google.maps.Point(17, 34),
        scaledSize: new google.maps.Size(25, 25)
      };

      // Create a marker for each place.
      var marker = new google.maps.Marker({
        map: map,
        icon: image,
        title: place.name,
        position: place.geometry.location
      });

      markers.push(marker);

      bounds.extend(place.geometry.location);
    }

    map.fitBounds(bounds);

    $.get("/walkscore", {address: input.value, lat: map.getCenter().lat(), lng: map.getCenter().lng()}, function(data) {
      $("#walk").html(data.walkscore);
    });

  });

}
