require("jquery-ui")
require("tag-it")

$(document).on("turbolinks:load", () => {
  if ($("#tag-it").length) {
    const messageId = $("#tag-it").data("message-id")
    const path = $("#tag-it").data("path")

    $("#tag-it").tagit({
      afterTagAdded: (e, ui) => {
        if (ui.duringInitialization) return
        $.post(path, { label: ui.tagLabel })
      },
      afterTagRemoved: (e, ui) => {
        $.ajax({ type: "DELETE", url: path, data: { label: ui.tagLabel } })
      }
    })
  }
})
