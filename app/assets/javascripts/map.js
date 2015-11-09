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
  });
}
