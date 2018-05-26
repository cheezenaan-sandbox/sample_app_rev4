# frozen_string_literal: true

class Users::FollowingController < ApplicationController
  before_action :authenticate_user!, only: :index

  def index; end
end
