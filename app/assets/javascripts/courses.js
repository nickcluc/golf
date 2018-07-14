// $(function() {
  // var autocomplete = new google.maps.places.Autocomplete(input);

  // var completer;
  //
  // completer = new GmapsCompleter({
  //   inputField: '#gmaps-input-name',
  //   errorField: '#gmaps-error'
  // });
  //
  // completer.autoCompleteInit({
  //   country: "us"
  // });
// });


var placeSearch, autocomplete;
var componentForm = {
  route: 'long_name',
  locality: 'long_name',
  administrative_area_level_1: 'short_name',
  postal_code: 'short_name'
};

function initAutocomplete() {
  var input = document.getElementById('gmaps-input-name');
  var options = {
    types: ['establishment']
  }

  autocomplete = new google.maps.places.Autocomplete(
    input,
    options
  );

  autocomplete.addListener('place_changed', fillInAddress);
}

function fillInAddress() {
  // Get the place details from the autocomplete object.
  var place = autocomplete.getPlace();

  for (var component in componentForm) {
    document.getElementById(component).value = '';
    document.getElementById(component).disabled = false;
  }

  // Get each component of the address from the place details
  // and fill the corresponding field on the form.
  document.getElementById('course_name').value = place.name;
  for (var i = 0; i < place.address_components.length; i++) {
    var addressType = place.address_components[i].types[0];
    if (componentForm[addressType]) {
      if (addressType == "route") {
        var numVal = place.address_components[0]['short_name']
        var streetVal = place.address_components[i][componentForm[addressType]];
        document.getElementById(addressType).value = numVal + ' ' + streetVal;
      } else {
        var val = place.address_components[i][componentForm[addressType]];
        document.getElementById(addressType).value = val;
      };
    }
  }
}

// Bias the autocomplete object to the user's geographical location,
// as supplied by the browser's 'navigator.geolocation' object.
function geolocate() {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      var geolocation = {
        lat: position.coords.latitude,
        lng: position.coords.longitude
      };
      var circle = new google.maps.Circle({
        center: geolocation,
        radius: position.coords.accuracy
      });
      autocomplete.setBounds(circle.getBounds());
    });
  }
}
