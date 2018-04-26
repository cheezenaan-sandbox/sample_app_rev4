# frozen_string_literal: true

class MicropostsController < ApplicationController
  before_action :authenticate_user!, only: %w[create destroy]

  def create
    @micropost = current_user.microposts.build(micropost_params)

    if @micropost.save
      flash[:success] = "Micropost created!!!"
      redirect_to root_url
    else
      render "static_pages/home"
    end
  end

  # TODO
  def destroy; end

  private

  def micropost_params
    params.require(:micropost).permit(:content)
  end
end
