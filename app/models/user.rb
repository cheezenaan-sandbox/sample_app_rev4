# frozen_string_literal: true

class User < ApplicationRecord
  attr_accessor :remember_token

  before_save { self.email = email.downcase }

  # Use ActiveModel::SecurePassword
  has_secure_password

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  validates :password, presence: true, length: { minimum: 6 }

  def remember
    self.remember_token = SecureToken.create
    update_attribute(:remember_digest, SecureDigest.digest(remember_token))
  end
end
