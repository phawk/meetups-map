function initMap() {
  navigator.geolocation.getCurrentPosition(function(pos) {
    var meLatLon = {lat: pos.coords.latitude, lng: pos.coords.longitude};

    var map = new google.maps.Map(document.getElementById('map'), {
      center: meLatLon,
      scrollwheel: false,
      zoom: 10
    });

    // Create a marker and set its position.
    var marker = new google.maps.Marker({
      map: map,
      position: meLatLon,
      title: 'You are here!'
    });

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
}
