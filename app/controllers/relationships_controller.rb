# frozen_string_literal: true

class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  # TODO: Enable to follow user through Ajax request
  def create
    user = User.find(params[:followed_id])
    current_user.follow(user) unless current_user.following?(user)
    redirect_to user
  end

  # TODO: Enable to unfollow user through Ajax request
  def destroy
    user = Relationship.find(params[:id]).followed
    current_user.unfollow(user)
    redirect_to user
  end
end
