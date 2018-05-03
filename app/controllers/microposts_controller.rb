# frozen_string_literal: true

class MicropostsController < ApplicationController
  before_action :authenticate_user!, only: %w[create destroy]

  def create
    @micropost = current_user.microposts.build(micropost_params)

    if @micropost.save
      flash[:success] = "Micropost created!!!"
      redirect_to root_url
    else
      @feeds = current_user.feeds.paginate(page: params[:page]) # TODO
      render "static_pages/home"
    end
  end

  def destroy
    @micropost = current_user.microposts.find_by(id: params[:id])
    return redirect_to root_url unless @micropost

    @micropost.destroy
    flash[:success] = "Micropost deleted..."
    redirect_back(fallback_location: root_url)
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content, :picture)
  end
end
