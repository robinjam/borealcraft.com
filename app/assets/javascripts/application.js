// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

(function($) {
  var num_screenshots = 6;
  
  $(function() {
    // Load all the screenshots
    for (var i = 1; i <= num_screenshots; i++)
      $(".wrapper > header").append('<img src="/assets/screenshots/' + i + '.png" data-id="' + i + '" class="screenshot"/>');

    cycleScreenshots(0);

    // Hide the flash messages
    $(".flash").delay(5000).slideUp(500);
  });

  // n = current image
  function cycleScreenshots(n) {
    var nextImageId = (n + 1) % num_screenshots + 1;
    var nextImage = getImage(nextImageId);
    nextImage.delay(5000).css("z-index", n);
    nextImage.fadeIn(1000, function() {
      getImage(n % num_screenshots + 1).hide();
      cycleScreenshots(n + 1);
    });
  }

  function getImage(n) {
    return $(".wrapper > header img[data-id='" + n + "']");
  }
})(jQuery);
