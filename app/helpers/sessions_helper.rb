# frozen_string_literal: true

module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def current_user
    return @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    return if cookies.signed[:user_id].blank?

    user = User.find_by(id: cookies.signed[:user_id])
    if user&.authenticated?(cookies[:remember_token])
      log_in(user)
      @current_user = user
    end
  end

  def current_user?(user)
    user == current_user
  end

  def logged_in?
    current_user.present?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
end
