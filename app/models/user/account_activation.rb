# frozen_string_literal: true

class User::AccountActivation < ApplicationRecord
  belongs_to :user

  def activated?
    activated_at.present?
  end

  def inactivated?
    !activated?
  end
end
