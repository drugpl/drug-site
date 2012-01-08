//= require jquery.googlemaps

$(document).ready(function() { 
  var lat = $("#map-location").data("lat");
  var lng = $("#map-location").data("lng");
  var zoom = parseInt($("#map-location").data("depth"));

  $('#map').googleMaps({
        latitude: lat,
        longitude: lng,
        scroll: true,
        depth: zoom,
        markers: {
            latitude: lat,
            longitude: lng
        }
    }); 
});
