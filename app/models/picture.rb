class Picture < ApplicationRecord
  # validates :title, presence: true
  default_scope -> { order(created_at: :desc) }
  validates :comment, length: { in: 0..140 }
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
  mount_uploader :image, ImageUploader
end
