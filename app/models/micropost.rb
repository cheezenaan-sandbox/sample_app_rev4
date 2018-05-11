# frozen_string_literal: true

class Micropost < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validate :picture_format
  validate :picture_size

  has_one_attached :picture

  scope :recent, -> { order(created_at: :desc) }

  private

  # TODO: Delete picture blob separately
  def picture_format
    extension_white_list = %w[jpg jpeg gif png]

    return unless picture.attached?
    return if extension_white_list.any? do |extension|
      picture.blob.content_type.starts_with?("image/#{extension}")
    end

    picture.purge
    errors.add(:picture, "は画像ファイルではありません")
  end

  def picture_size
    return unless picture.attached?

    if picture.blob.byte_size > 5.megabytes
      picture.purge
      errors.add(:picture, "should be less than 5MB")
    end
  end
end
