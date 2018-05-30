# frozen_string_literal: true

class Users::FollowersController < ApplicationController
  before_action :authenticate_user!, only: :index

  def index
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])

    render "users/show_follow"
  end
end
