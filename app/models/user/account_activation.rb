# frozen_string_literal: true

class User::AccountActivation < ApplicationRecord
  belongs_to :user

  scope :activated, -> { where.not(activated_at: nil) }
  scope :inactivated, -> { where(activated_at: nil) }

  def activated?
    activated_at.present?
  end

  def inactivated?
    !activated?
  end

  def authenticated?(token)
    SecureDigest.new(digest).is_digest?(token)
  end
end
