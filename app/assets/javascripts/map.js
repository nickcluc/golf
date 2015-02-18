var mapCenter;
  if (! searchCity){
    var searchCity = "";
  }
  geocoder = new google.maps.Geocoder();

  geocoder.geocode({'address': searchCity}, function(results, status){
    mapCenter = results[0].geometry.location;
  });
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
  }
  else if (pointCount == 1) {
    map.setCenter(bounds.getCenter());
    map.setZoom(13);
  }
}


google.maps.event.addDomListener(
  window,
  'load',
  function () {
    //1000 milliseconds == 1 second,
    //play with this til find a happy minimum delay amount
    window.setTimeout(initialize, 0);
  }
);
