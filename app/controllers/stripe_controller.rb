class StripeController < ApplicationController
  STRIPE_CONNECT_URL = 'https://connect.stripe.com'

  before_action :set_client

  def authorize
    connect_params = {
      scope: 'read_write',
      redirect_uri: callback_url
    }

    redirect_to @client.auth_code.authorize_url(connect_params)
  end

  def callback
    if params[:code]
      User.stripe_connect(stripe_attributes)
    end

    redirect_to root_url
  end

private

  def set_client
    @client ||= OAuth2::Client.new(
      ENV['STRIPE_CLIENT_ID'],
      ENV['STRIPE_SECRET_KEY'],
      site: STRIPE_CONNECT_URL
    )
  end

  def auth_token
    @auth_token ||= @client.auth_code.get_token(params[:code])
  end

  def stripe_attributes
    {
      stripe_user_id: auth_token.params['stripe_user_id'],
      stripe_token: auth_token.token,
      stripe_publishable_key: auth_token.params['stripe_publishable_key']
    }
  end
end
