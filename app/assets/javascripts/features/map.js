$(function() {
  var meetupMarkers = {},
      youMarker, map;

  var map = window.map = new google.maps.Map(document.getElementById('map'), {
    center: {lat: 51.5073, lng: -0.12274},
    scrollwheel: false,
    zoom: 11
  });

  function loadMeetups(city) {
    var geocoder = new google.maps.Geocoder();

    // Remove all markers
    if (youMarker) youMarker.setMap(null);

    _.each(meetupMarkers, function(marker, meetupId) {
      marker.setMap(null);
    });

    meetupMarkers = {};

    geocoder.geocode({ 'address': city }, function(results, status) {
      if (status == google.maps.GeocoderStatus.OK) {
        var location = results[0].geometry.location;

        map.setCenter(location);
        map.setZoom(11);

        youMarker = new google.maps.Marker({
            map: map,
            position: location,
            title: 'You are here!'
        });

        $.ajax({
          url: "/meetups/nearby",
          type: "GET",
          data: {
            lat: location.lat,
            lon: location.lng
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

            meetupMarkers[meetup.id] = marker;

            marker.addListener('click', function() {
              infowindow.open(map, marker);
            });
          });
        });

      } else {
        alert("Geocode was not successful for the following reason: " + status);
      }
    });
  }

  $(document).on("submit", ".search-form", function(ev) {
    loadMeetups($("#location").val());

    return false;
  });

  loadMeetups("London");

});
