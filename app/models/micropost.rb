# frozen_string_literal: true

class Micropost < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }

  has_one_attached :picture

  scope :recent, -> { order(created_at: :desc) }
end
