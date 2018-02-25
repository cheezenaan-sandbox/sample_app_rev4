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
      @user.activation_token = SecureToken.create
      @user.activation_digest = SecureDigest.digest(@user.activation_token)
      @user.save!

      UserMailer.account_activation(@user).deliver_now!
    end
  end

  private_class_method :new
end
