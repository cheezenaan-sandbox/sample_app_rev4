# frozen_string_literal: true

class User::PasswordResetMailSenderService
  class << self
    def call(user:)
      new(user).call
    end
  end

  def initialize(user)
    @user = user
  end

  def call
    return unless @user.present?

    ActiveRecord::Base.transaction do
      @user.reset_token = SecureToken.create
      @user.reset_digest = SecureDigest.digest(@user.reset_token)
      @user.reset_sent_at = Time.zone.now
      @user.save!

      UserMailer.password_reset(@user).deliver_now!
    end
  end

  private_class_method :new
end
