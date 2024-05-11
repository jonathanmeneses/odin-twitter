class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable

  validates :content, length: { minimum: 1, message: "must be at least 1 character" }, unless: -> {content.blank? && (image.attached? || image_url.present?)}

  validates :content, presence: true, unless: -> { image.attached? || image_url.present? }
  validates :image_url, url: true, allow_blank: true
end
