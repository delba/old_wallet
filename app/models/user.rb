class User < ActiveRecord::Base
  serialize :currencies_supported

  def self.stripe_connect(stripe_attributes)
    user = find_by(stripe_user_id: stripe_attributes[:stripe_user_id])

    unless user
      user = new(stripe_attributes)
      account = Stripe::Account.retrieve(user.stripe_token)
      user.default_currency = account.default_currency
      user.currencies_supported = account.currencies_supported
      user.save
    end

    user
  end
end
