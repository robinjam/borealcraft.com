$(document).on "page:fetch", ->
  $(".main .wrapper").animate opacity: 0

$(document).on "page:change", ->
  $(".main .wrapper").css(opacity: 0).animate opacity: 1
