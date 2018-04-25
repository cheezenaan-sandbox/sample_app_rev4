# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionHelper

  private

  def authenticate_user!
    return if logged_in?

    store_location
    flash[:danger] = "Please log in."
    redirect_to login_url
  end
end
