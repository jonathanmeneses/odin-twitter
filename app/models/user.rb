class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true, uniqueness: true
  validate :avatar_format

  # Associations
  # Note, we're going to have this destroy all of a users content when a user is destroyed. Might come back later
  # and implement the reddit style functionality ofjust showing a user as deleted, but not their content
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  has_one_attached :avatar

  private
  def avatar_format
    return unless avatar.attached?

    if avatar.blob.byte_size > 10.megabytes
      errors.add(:avatar, 'size needs to be less than 10MB')
      avatar.purge
    elsif !avatar.blob.content_type.start_with? 'image/'
      errors.add(:avatar, 'needs to be an image')
      avatar.purge
    end
  end

end
