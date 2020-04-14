function update_number_of_unprocessed_messages() {
  const elem = $("#number-of-unprocessed-messages")
  $.get(elem.data("path"), (data) => {
    if (data == "0") elem.text("")
    else elem.text("(" + data + ")")
  })
  .fail(() => window.location.href = "/")
}

$(document).ready(() => {
  if ($("#number-of-unprocessed-messages").length)
    window.setInterval(update_number_of_unprocessed_messages, 1000 * 60)
})
