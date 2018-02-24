# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: session_params[:email].downcase)

    unless user&.authenticate(session_params[:password])
      flash.now[:danger] = "Invalid email/password combination"
      return render "new"
    end

    if user&.activated?
      log_in(user)
      remember_me? ? remember(user) : forget(user)
      redirect_to(stored_location || user)
    else
      message = "Account not activated. Check your email for the activation link."
      flash[:warning] = message
      redirect_to root_url
    end
  end

  def destroy
    forget(current_user) if logged_in?
    log_out
    redirect_to root_url
  end

  private

  def session_params
    params.require(:session).permit(:email, :password, :remember_me)
  end

  def remember_me?
    session_params[:remember_me] == "1"
  end
end
