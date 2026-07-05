class Photo < ApplicationRecord
  belongs_to :user

  has_one_attached :image

  validates :position, presence: true, inclusion: { in: 0..5 }
  validates :position, uniqueness: { scope: :user_id }
end