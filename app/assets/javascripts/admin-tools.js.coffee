$(document).on "ready page:load", ->
  $("#admin-tools-checkbox")
    .css("display", "inline")
    .find(":checkbox")
      .change ->
        $("[data-admin-tool]").toggle()
      .prop("checked", true)
      .click()
