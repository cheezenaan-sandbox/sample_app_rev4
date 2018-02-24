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
    activation = @user.account_activation
    return unless activation.inactivated? && activation.authenticated?(@token)

    activation.update_attributes!(activated_at: Time.zone.now)
  end

  private_class_method :new
end
