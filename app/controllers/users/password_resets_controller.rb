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

  def edit
    @user = User.find_by(email: params[:email])
    redirect_if_invalid_user(user: @user, token: params[:id])
    redirect_if_password_reset_expired(@user)
  end

  def update
    @user = User.find_by(email: params[:email])
    redirect_if_invalid_user(user: @user, token: params[:id])
    redirect_if_password_reset_expired(@user)

    if password_reset_update_params[:password].blank?
      @user.errors.add(:password, :blank)
      return render "edit"
    end

    if @user.update_attributes(password_reset_update_params)
      log_in(@user)
      flash[:success] = "Password has been reset..."
      redirect_to @user
    else
      render "edit"
    end
  end

  private

  def password_reset_params
    params.require(:password_reset).permit(:email)
  end

  def password_reset_update_params
    params.require(:user).permit(:password, :password_confimation)
  end

  def redirect_if_invalid_user(user:, token:)
    return if user&.activated? && user&.reset_authenticated?(token)
    redirect_to root_url
  end

  def redirect_if_password_reset_expired(user)
    return unless user.password_reset_expired?

    flash[:danger] = "Password reset has been expired."
    redirect_to new_users_password_reset_url
  end
end
