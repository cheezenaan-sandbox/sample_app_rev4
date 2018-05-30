# frozen_string_literal: true

class Users::FollowingController < ApplicationController
  before_action :authenticate_user!, only: :index

  def index
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])

    render "users/show_follow"
  end
end
