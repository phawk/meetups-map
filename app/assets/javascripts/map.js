$(function() {
  navigator.geolocation.getCurrentPosition(function(pos) {
    var meLatLon = {lat: pos.coords.latitude, lng: pos.coords.longitude};

    var map = new google.maps.Map(document.getElementById('map'), {
      center: meLatLon,
      scrollwheel: false,
      zoom: 11
    });

    // Create a marker and set its position.
    var marker = new google.maps.Marker({
      map: map,
      position: meLatLon,
      title: 'You are here!'
    });

    // var searchRadius = new google.maps.Circle({
    //   strokeColor: '#FF0000',
    //   strokeOpacity: 0.8,
    //   strokeWeight: 2,
    //   fillColor: '#FF0000',
    //   fillOpacity: 0.35,
    //   map: map,
    //   center: meLatLon,
    //   radius: 15000
    // });

    try {
      var searchRadius = new InvertedCircle({
          center: map.getCenter(),
          map: map,
          radius: 15000, // 15 km
          editable: false,
          stroke_weight: 0,
          fill_opacity: 0.5,
          fill_color: "#000"
      });
    } catch(e) {
      console.error(e);
    }

    // Find nearby stores
    $.ajax({
      url: "/stores/nearby",
      type: "GET",
      data: {
        lat: meLatLon.lat,
        lon: meLatLon.lng
      }
    }).then(function(data) {
      console.log("Store nearby", data);
      data.stores.forEach(function(store) {

        var infowindow = new google.maps.InfoWindow({
          content: [
            "<h1>"+store.name+ "</h1>",
            "<p>",
              store.street_address.split("\n").join("<BR>"),
            "</p>"
          ].join("\n")
        });

        var marker = new google.maps.Marker({
          map: map,
          position: {lat: store.latitude, lng: store.longitude},
          title: store.name
        });

        marker.addListener('click', function() {
          infowindow.open(map, marker);
        });
      });
    });
  });
});
