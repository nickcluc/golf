$(document).ready(function()
    {
        $(".tablesorter").tablesorter();
    }
);

$( "#friend-request-button" ).click(function() {
  $( "#friend-request-list" ).toggle( "slow", function() {
  });
});
