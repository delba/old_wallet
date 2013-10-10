class Charge < ActiveRecord::Base
  belongs_to :user

  attr_accessor :stripe_token

  before_create do
    self.amount = amount.to_i * 100

    stripe_charge = Stripe::Charge.create({
      amount: amount,
      card: stripe_token,
      currency: currency,
      description: 'Wallet'
    }, user.stripe_token)

    self.stripe_id = stripe_charge.id
  end
end
