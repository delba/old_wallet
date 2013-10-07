class UsersController < ApplicationController
  before_action :set_user

  def show
  end

  def donate
    redirect_to @user
  end

private

  def set_user
    @user = User.find(params[:id])
  end
end
