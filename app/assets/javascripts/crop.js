function update_crop(coords) {
  $('#profile_photo_crop_x').val(coords.x);
  $('#profile_photo_crop_y').val(coords.y);
  $('#profile_photo_crop_w').val(coords.w);
  $('#profile_photo_crop_h').val(coords.h);
}

jQuery(function($) {
    $('#edit-photo').Jcrop({
        boxHeight: 400,
        boxWidth: 400,
        bgColor: 'black',
        bgOpacity: .4,
        aspectRatio: 1,
        addClass: 'jcrop-dark',
        onChange: update_crop,
        onSelect: update_crop
    });
});
