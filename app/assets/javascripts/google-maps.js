//= require gmap3.min

$(document).ready(function() { 
  var lat, lng, zoom;

  $(".map").each(function() {
    lat = $(this).data("lat");
    lng = $(this).data("lng");
    depth = parseInt($(this).data("depth"));

    $(this).gmap3({
      map: {
        options: {
          center: [lat, lng],
          zoom: 14,
          mapTypeControl: true,
          navigationControl: true,
          scrollwheel: true,
        }
      },
      marker: {
        latLng: [lat, lng],
      }
    });
  });
});
