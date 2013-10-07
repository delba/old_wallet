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

$form = $('#donation')
$stripe_token = $form.find('#stripe_token')
$card_number = $form.find('#card_number')
$expiration_date = $form.find('#expiration_date')
$cvc = $form.find('#cvc')

# Format Card Inputs

$form.formatCard()

# Validate Payment fields

$card_number.on 'input', (e) ->
  $this = $(this)
  valid = $.payment.validateCardNumber $this.val()
  $this.toggleClass 'valid', valid

$expiration_date.on 'input', (e) ->
  $this = $(this)
  date = $this.payment('cardExpiryVal')
  valid = $.payment.validateCardExpiry date.month, date.year
  $this.toggleClass 'valid', valid

$cvc.on 'input', (e) ->
  $this = $(this)
  cardType = $.payment.cardType $card_number.val()
  valid = $.payment.validateCardCVC $this.val(), cardType
  $this.toggleClass 'valid', valid

# Get Stripe Token

$form.on 'submit', (e) ->
  e.preventDefault()

  $form.find('input[type="submit"]').prop('disabled', true)

  cardData = $form.cardData()

  Stripe.card.createToken(cardData, stripeResponseHandler)

stripeResponseHandler = (status, response) ->
  $form.find('.errors').remove()

  if response.error
    $form.prepend "<p class='errors'>#{response.error.message}</p>"
    $form.find('input[type="submit"]').prop('disabled', false)
  else
    $stripe_token.val response.id
    $form.get(0).submit()
