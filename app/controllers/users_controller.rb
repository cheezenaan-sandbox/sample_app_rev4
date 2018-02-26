# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[index edit update destroy]

  def index
    @users = User.activated.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    return redirect_to root_url if @user.inactivated?
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if User::CreatorService.call(user: @user)
      redirect_to root_url
      flash[:info] = "Please check your email to activate your account."
    else
      render "new"
    end
  end

  def edit
    @user = User.find(params[:id])
    return redirect_to root_url unless current_user?(@user)
  end

  def update
    @user = User.find(params[:id])
    return redirect_to root_url unless current_user?(@user)

    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated!!!!!!"
      redirect_to @user
    else
      render "edit"
    end
  end

  def destroy
    return redirect_to root_url unless current_user.admin?

    User.find(params[:id]).destroy
    flash[:success] = "User has been deleted"
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def authenticate_user!
    return if logged_in?

    store_location
    flash[:danger] = "Please log in."
    redirect_to login_url
  end
end
