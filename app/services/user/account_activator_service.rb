# frozen_string_literal: true

class User::AccountActivatorService
  class << self
    def call(user:, token:)
      new(user, token).call
    end
  end

  def initialize(user, token)
    @user = user
    @token = token
  end

  def call
    return unless @user.inactivated? && @user.activation_authenticated?(@token)

    @user.update_attributes!(activated: true, activated_at: Time.zone.now)
  end

  private_class_method :new
end
