$(function() {
  // navigator.geolocation.getCurrentPosition(function(pos) {
    // var meLatLon = {lat: pos.coords.latitude, lng: pos.coords.longitude};
    var meLatLon = {lat: 51.5073, lng: -0.12274};

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

    try {
      var searchRadius = new InvertedCircle({
          center: map.getCenter(),
          map: map,
          radius: 50000, // 50 km
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
      url: "/meetups/nearby",
      type: "GET",
      data: {
        lat: meLatLon.lat,
        lon: meLatLon.lng
      }
    }).then(function(data) {

      var meetups_html = JST["templates/meetups"]({meetups: data.meetups});
      $(".meetups-list").html(meetups_html);

      data.meetups.forEach(function(meetup) {

        var infowindow = new google.maps.InfoWindow({
          content: JST["templates/meetup_marker_popup"]({meetup: meetup})
        });

        var marker = new google.maps.Marker({
          map: map,
          position: {lat: meetup.latitude, lng: meetup.longitude},
          title: meetup.name
        });

        marker.addListener('click', function() {
          infowindow.open(map, marker);
        });
      });
    });
  // });
});
