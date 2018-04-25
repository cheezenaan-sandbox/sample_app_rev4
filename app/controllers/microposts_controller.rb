# frozen_string_literal: true

class MicropostsController < ApplicationController
  before_action :authenticate_user!, only: %w[create destroy]

  # TODO
  def create; end

  # TODO
  def destroy; end
end
