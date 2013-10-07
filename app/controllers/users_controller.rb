class UsersController < ApplicationController
  before_action :set_user

  def show
  end

  def donate
    Stripe::Charge.create({
      amount: amount,
      card: params[:stripe_token],
      currency: 'USD',
      description: 'Wallet'
    }, @user.stripe_token)
  rescue Stripe::CardError => e
    logger.info e
  ensure
    redirect_to @user
  end

private

  def set_user
    @user = User.find(params[:id])
  end

  def amount
    (params[:amount].to_f * 100).to_i
  end
end
