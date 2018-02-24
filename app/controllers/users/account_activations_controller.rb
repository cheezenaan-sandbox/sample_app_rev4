# frozen_string_literal: true

class Users::AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])

    if User::AccountActivatorService.call(user: user, token: params[:id])
      log_in(user)
      flash[:success] = "Account activated!!!!!"
      redirect_to user
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end
end
