ready = ->
  return unless $('#amount').length

  $('#amount').payment('restrictNumeric')

$(document).on('ready', ready)
$(document).on('page:change', ready)
