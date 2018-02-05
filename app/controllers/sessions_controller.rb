# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: session_params[:email].downcase)

    if user&.authenticate(session_params[:password])
      # TODO: redirect_to user
    else
      # FIXME: this message doesn't disappear even when jumping to another page
      flash[:danger] = "Invalid email/password combination"
      render "new"
    end
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
