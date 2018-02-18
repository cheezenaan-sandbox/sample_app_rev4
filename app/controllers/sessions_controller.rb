# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: session_params[:email].downcase)

    if user&.authenticate(session_params[:password])
      log_in(user)
      remember_me? ? remember(user) : forget(user)
      redirect_to(stored_location || user)
    else
      flash.now[:danger] = "Invalid email/password combination"
      render "new"
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
