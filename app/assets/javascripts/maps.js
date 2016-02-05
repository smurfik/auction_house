var map;

navigator.geolocation.getCurrentPosition(function(position){
  var lat = position.coords.latitude;
  var lng = position.coords.longitude;
  map.setCenter({lat: lat, lng: lng});
  });

var setMarkerPosition = function(d) {
  this.setPosition(d[0].geometry.location);
};

function initialize() {

  var bidaddress, bidmarker, bidstreet, bidcity, bidstate;
  var bidmarkers = [];
  var pinsgeocoder = new google.maps.Geocoder();
  $.get("/place-pins", function(data) {
    for (i = 0; i < data.length; i++) {
      bidaddress = data[i].address+data[i].city+data[i].state;
      bidstreet = data[i].address;
      bidcity = data[i].city;
      bidstate = data[i].state;
      bidmarker = new google.maps.Marker({
        map: map
      });

      bidmarker.address = bidaddress;
      bidmarker.street = bidstreet;
      bidmarker.city = bidcity;
      bidmarker.state = bidstate;

      bidmarkers.push(bidmarker);

      bidmarker.addListener('click', function() {
        $.get("/house", {
          street: this.street,
          city: this.city,
          state: this.state
        }, function(data) {
          $(".zpid").val(data.zpid);
          $(".street").val(data.street);
          $(".city").val(data.city);
          $(".state").val(data.state);
          $(".zip").val(data.zipcode);
          $(".street").html(data.street);
          $(".city").html(data.city);
          $(".state").html(data.state);
          $(".zip").html(data.zipcode);
          $(".bath").html(data.bathrooms);
          $(".bedrooms").html(data.bedrooms);
          $(".type").html(data.type);
          $(".zestimate").html(data.zestimate.replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,"));
          $(".year").html(data.yearBuilt);
          $(".sqft").html(data.sqft.replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,"));
          $(".lotsqft").html(data.lotSizeSqFt.replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,"));
          $(".neighborhood").html(data.neighborhood);
          if (!data.images) {
            $(".image").attr("src", "http://www.croestate.com/assets/images/no_photo.png");
            $(".zillow-pictures").html("");
            $(".zillow-pictures").removeClass("zillow-pictures");
          } else if (parseInt(data.images.count) > 1) {
              $(".zillow-pictures").html("");
              $(".image").attr("src", data.images.image.url[0]);
              var z_images = data.images.image.url;
              for (i = 0; i < z_images.length; i++) {
                $(".zillow-pictures").prepend('<img src="' + z_images[i] + '" />');
              }
          } else {
            $(".zillow-pictures").html("");
            $(".image").attr("src", data.images.image.url);
          }
          if (data.description) {
            $(".description").html(data.homeDescription);
          } else {
            $(".auto-describe").show();
          }
          if (data.rent) {
            $(".rent").html(data.rent.replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,"));
          } else {
            $(".rent").html("NA");
          }
          if (data.sold_date) {
            $(".sold-date").html(data.sold_date);
          } else {
            $(".sold-date").html("NA");
          }
          if (data.sold_price) {
            $(".sold-price").html(data.sold_price.replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,"));
          } else {
            $(".sold-price").html("NA");
          }
        });
          $.get("/bid-data", {zpid: data.zpid}, function(data) {
            if (data.length === 0) {
              $(".zebra").html("");
              $(".no-bids").html("");
              $(".no-bids").prepend("<p> No bids have been placed on this home. Let's get this party started! </p>");
            } else {
                $(".bid-create-date").html("");
                $(".bid-price").html("");
                // Reverse ordering the bids
                for (i = data.length - 1; i >= 0; i--) {
                  $(".zebra").append('<tr><td>' + prettyDate(data[i].created_at) + '</td><td> $' + data[i].price + '</td></tr>');
                }
              }
        });
      });
    }
    for (i = 0; i < bidmarkers.length; i++) {
      pinsgeocoder.geocode({address: bidmarkers[i].address}, setMarkerPosition.bind(bidmarkers[i]))
    }
  });

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

    var geocoder = new google.maps.Geocoder();


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

    $(".sidebar.first-load").removeClass("first-load");
    $("#map-canvas.map-first-load").removeClass("map-first-load");

    $.get("/walkscore", {
      address: input.value,
      lat: map.getCenter().lat(),
      lng: map.getCenter().lng()
    }, function(data) {
      $(".walk").html(data.walkscore);
    });

    geocoder.geocode({location: map.getCenter()}, function(location){

        $(".notice").html(" ");
        $('.form').hide();
        $(".bid-now-button").show();
        $('.bid-form').removeClass("styled");
        $('.bid-now-button').removeClass("styled-bid-button");


        var place = location[0];
        var street_number;
        var street_name;
        var city;
        var state;

       for (i=0; i < place.address_components.length; i++) {
         var type = place.address_components[i].types[0];
         if (type === "street_number") {
          street_number = place.address_components[i].short_name;
        } else if (type === "route") {
          street_name = place.address_components[i].short_name;
        } else if (type === "locality") {
          city = place.address_components[i].short_name;
        } else if (type === "administrative_area_level_1") {
           state = place.address_components[i].short_name;
        }
       }


       var street = street_number + " " + street_name;

      $.get("/house", {
        street: street,
        city: city,
        state: state
      }, function(data) {
        $(".zpid").val(data.zpid);
        $(".street").val(data.street);
        $(".city").val(data.city);
        $(".state").val(data.state);
        $(".zip").val(data.zipcode);
        $(".street").html(data.street);
        $(".city").html(data.city);
        $(".state").html(data.state);
        $(".zip").html(data.zipcode);
        $(".bath").html(data.bathrooms);
        $(".bedrooms").html(data.bedrooms);
        $(".type").html(data.type);
        $(".zestimate").html(data.zestimate.replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,"));
        $(".year").html(data.yearBuilt);
        $(".sqft").html(data.sqft.replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,"));
        $(".lotsqft").html(data.lotSizeSqFt.replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,"));
        $(".neighborhood").html(data.neighborhood);
        if (!data.images) {
          $(".image").attr("src", "http://www.croestate.com/assets/images/no_photo.png");
          $(".zillow-pictures").html("");
          $(".zillow-pictures").removeClass("zillow-pictures");
        } else if (parseInt(data.images.count) > 1) {
            $(".zillow-pictures").html("");
            $(".image").attr("src", data.images.image.url[0]);
            var z_images = data.images.image.url;
            for (i = 0; i < z_images.length; i++) {
              $(".zillow-pictures").prepend('<img src="' + z_images[i] + '" />');
            }
        } else {
          $(".zillow-pictures").html("");
          $(".image").attr("src", data.images.image.url);
        }
        if (data.description) {
          $(".description").html(data.homeDescription);
        } else {
          $(".auto-describe").show();
        }
        if (data.rent) {
          $(".rent").html(data.rent.replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,"));
        } else {
          $(".rent").html("NA");
        }
        if (data.sold_date) {
          $(".sold-date").html(data.sold_date);
        } else {
          $(".sold-date").html("NA");
        }
        if (data.sold_price) {
          $(".sold-price").html(data.sold_price.replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,"));
        } else {
          $(".sold-price").html("NA");
        }
        // 2nd argument is sending the params.  the key 'zpid:' in this scenario must match the params in the bid_data method (HousesController)
        $.get("/bid-data", {zpid: data.zpid}, function(data) {
          if (data.length === 0) {
            $(".zebra").html("");
            $(".no-bids").html("");
            $(".no-bids").prepend("<p> No bids have been placed on this home. Let's get this party started! </p>");
          } else {
              $(".bid-create-date").html("");
              $(".bid-price").html("");
              // Reverse ordering the bids
              for (i = data.length - 1; i >= 0; i--) {
                $(".zebra").append('<tr><td>' + prettyDate(data[i].created_at) + '</td><td> $' + data[i].price + '</td></tr>');
              }
            }
          });
        });
      });
    });
    $(".form").on("submit", function(e){
      e.preventDefault();
      var details = $(".form").serialize();
      $.post("/bid", details, function(data) {
        $(".notice").html(data.notice);
      });
    });
  }
