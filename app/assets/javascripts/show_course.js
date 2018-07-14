$( "#add_tee_button" ).click(function() {
  $( "#add_tee_form" ).toggle( "slow", function() {
  });
});

var mapCenter;
// if (! searchCity){
//   var searchCity = "";
// }


function initialize() {
  var map;
  var elevator;

  var mapOptions = {
    zoom: 14,
    center: mapCenter,
    disableDefaultUI: false
  };

  map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);

  var bounds = new google.maps.LatLngBounds();
  var pointCount = 0;
  for (var x = 0; x < addresses.length; x++) {
    var p = addresses[x];
    var latlng = new google.maps.LatLng(p[0], p[1]);
    new google.maps.Marker({
      position: latlng,
      map: map
    });
    pointCount++;
    bounds.extend(latlng);
  }

  if (pointCount > 1) {
    map.fitBounds(bounds);
  } else if (pointCount == 1) {
    map.setCenter(bounds.getCenter());
    map.setZoom(13);
  }
}

google.maps.event.addDomListener(
  window,
  'load',
  function () {
    window.setTimeout(initialize, 500);
  }
);
