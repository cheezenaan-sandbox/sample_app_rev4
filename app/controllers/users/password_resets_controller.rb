# frozen_string_literal: true

class Users::PasswordResetsController < ApplicationController
  def new; end

  def create
    @user = User.find_by(email: password_reset_params[:email])

    if User::PasswordResetMailSenderService.call(user: @user)
      flash[:info] = "Email sent with password reset insturctions"
      redirect_to root_url
    else
      flash.now[:danger] = "Email address not found.."
      render "new"
    end
  end

  def edit; end

  private

  def password_reset_params
    params.require(:password_reset).permit(:email)
  end
end
