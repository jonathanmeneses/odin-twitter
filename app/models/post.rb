class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable

  validates :content, length: { minimum: 10, message: "must be at least 10 characters long" }
end
