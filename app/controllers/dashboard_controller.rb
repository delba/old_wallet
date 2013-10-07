class DashboardController < ApplicationController
  STRIPE_CONNECT_URL = 'https://connect.stripe.com'

  before_action :set_client, only: [:connect, :callback]

  def index
  end

  def connect
    connect_params = {
      scope: 'read_write',
      redirect_uri: callback_url
    }

    redirect_to @client.auth_code.authorize_url(connect_params)
  end

  def callback
    if params[:code]
      @auth_token = @client.auth_code.get_token(params[:code])
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
end
