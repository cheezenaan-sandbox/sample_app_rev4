# frozen_string_literal: true

class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  attr_accessor :remember_token, :activation_token, :reset_token

  has_many :microposts, dependent: :destroy

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  # Use ActiveModel::SecurePassword
  has_secure_password

  scope :activated, -> { where(activated: true) }
  scope :inactivated, -> { where(activated: false) }

  def remember
    self.remember_token = SecureToken.create
    update_attribute(:remember_digest, SecureDigest.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.blank?
    SecureDigest.new(remember_digest).is_digest?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def inactivated?
    !activated?
  end

  # TODO: Summarize other `#authenticated?` methods
  def activation_authenticated?(activation_token)
    SecureDigest.new(activation_digest).is_digest?(activation_token)
  end

  def reset_authenticated?(reset_token)
    SecureDigest.new(reset_digest).is_digest?(reset_token)
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  # TODO
  def feeds
    microposts.recent.with_attached_picture
  end
end
