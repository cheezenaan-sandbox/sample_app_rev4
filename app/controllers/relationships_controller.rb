# frozen_string_literal: true

class RelationshipsController < ApplicationController
  before_action :authenticate_user!, before: :create

  def create
    user = User.find(params[:followed_id])
    current_user.follow(user) unless current_user.following?(user)
    redirect_to user
  end
end
