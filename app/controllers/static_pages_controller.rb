# frozen_string_literal: true

class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @micropost = current_user.microposts.build
      @feeds = current_user.feeds.paginate(page: params[:page])
    end
  end

  def help; end

  def about; end

  def contact; end
end
