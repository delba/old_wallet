class User < ActiveRecord::Base
  def self.stripe_connect(stripe_attributes)
    create_with(stripe_attributes).
    find_or_create_by(stripe_user_id: stripe_attributes[:stripe_user_id])
  end
end
