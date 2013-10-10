class ChargesController < ApplicationController
  before_action :set_user

  def create
    @user.charges.create!(charge_params)
    flash.notice = 'Thank you!'
  rescue Stripe::CardError => e
    logger.info e
  ensure
    redirect_to @user
  end

private

  def charge_params
    {
      currency: params[:currency],
      amount: params[:amount],
      stripe_token: params[:stripe_token]
    }
  end

  def set_user
    @user = User.find(params[:user_id])
  end
end
