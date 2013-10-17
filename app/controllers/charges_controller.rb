class ChargesController < ApplicationController
  before_action :set_user

  def new
    @amount = params[:amount].presence
    @currency = params[:currency].presence

    unless @amount && @currency
      redirect_to @user
    end
  end

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
    params.require(:charge).permit(
      :currency,
      :amount,
      :stripe_token
    )
  end

  def set_user
    @user = User.find(params[:user_id])
  end
end
