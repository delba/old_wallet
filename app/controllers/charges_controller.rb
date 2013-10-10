class ChargesController < ApplicationController
  before_action :set_user

  def create
    Stripe::Charge.create({
      amount: params[:amount].to_i * 100,
      card: params[:stripe_token],
      currency: params[:currency],
      description: 'Wallet'
    }, @user.stripe_token)

    flash.notice = 'Thank you!'
  rescue Stripe::CardError => e
    logger.info e
  ensure
    redirect_to @user
  end

private

  def set_user
    @user = User.find(params[:user_id])
  end
end
