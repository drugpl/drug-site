$(document).ready(function() { 
  var lat = $("#map-location").customdata("lat");
  var lng = $("#map-location").customdata("lng");
  var zoom = parseInt($("#map-location").customdata("depth"));

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
