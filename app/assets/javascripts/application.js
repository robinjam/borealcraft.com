// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

// Wait 5 seconds
// Fade in image tag
// Set background tag to new image
// Wait 5 seconds
// Fade out image tag
// Set image tag to new image
// Repeat

var num_screenshots = 5;

$(function() {
  cycleScreenshots(1);
});

function cycleScreenshots(n) {
  $("#screenshot").attr("src", getScreenshot(n % num_screenshots + 1));
  $("#screenshot").delay(5000).fadeIn(2000, function() {
    $(".wrapper > header").css("background-image", "url('" + getScreenshot((n+1) % num_screenshots + 1) + "')");
    $("#screenshot").delay(5000).fadeOut(2000, function() {cycleScreenshots(n+2)});
  })
}

function getScreenshot(n) {
  return "assets/screenshots/" + n + ".png";
}
