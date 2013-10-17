$.fn.formatCard = ->
  @find('#card_number').payment('formatCardNumber')
  @find('#cvc').payment('formatCardCVC')
  @find('#expiration_date').payment('formatCardExpiry')

$.fn.cardData = ->
  expiration = @find('#expiration_date').payment('cardExpiryVal')

  name: @find('#name').val()
  number: @find('#card_number').val()
  cvc: @find('#cvc').val()
  exp_month: expiration.month or null
  exp_year: expiration.year or null

# Validate Payment fields

$(document).on 'input', '#card_number', (e) ->
  $this = $(this)
  valid = $.payment.validateCardNumber $this.val()
  $this.toggleClass 'valid', valid

$(document).on 'input', '#expiration_date', (e) ->
  $this = $(this)
  date = $this.payment('cardExpiryVal')
  valid = $.payment.validateCardExpiry date.month, date.year
  $this.toggleClass 'valid', valid

$(document).on 'input', '#cvc', (e) ->
  $this = $(this)
  cardType = $.payment.cardType $('#card_number').val()
  valid = $.payment.validateCardCVC $this.val(), cardType
  $this.toggleClass 'valid', valid

# Get Stripe Token

$(document).on 'submit', '#payment', (e) ->
  e.preventDefault()

  $this = $(this)

  $this.find('input[type="submit"]').prop('disabled', true)

  cardData = $this.cardData()

  Stripe.card.createToken(cardData, stripeResponseHandler)

stripeResponseHandler = (status, response) ->
  $form = $('#payment')

  $form.find('.errors').remove()

  if response.error
    $form.prepend "<p class='errors'>#{response.error.message}</p>"
    $form.find('input[type="submit"]').prop('disabled', false)
  else
    $form.find('#stripe_token').val response.id
    $form.get(0).submit()

@Payment =
  init: ->
    $form = $('#payment')

    $form.formatCard()
    Stripe.setPublishableKey $form.find('#stripe_publishable_key').val()

# Customer

$(document).on 'click', '#remember_me', (e) ->
  $('.customer').toggleClass('hidden', !$(this).is(':checked'))
