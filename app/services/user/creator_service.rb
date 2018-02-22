# frozen_string_literal: true

class User::CreatorService
  class << self
    def call(user:)
      new(user).call
    end
  end

  def initialize(user)
    @user = user
  end

  def call
    return unless @user.valid?

    ActiveRecord::Base.transaction do
      @user.email = @user.email.downcase
      @user.save!

      activation_token = SecureToken.create
      @user.create_account_activation!(
        digest: SecureDigest.digest(activation_token),
      )
    end
  end

  private_class_method :new
end
