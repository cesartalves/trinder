class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :potential_matches_as_user_1,
           class_name: "PotentialMatch",
           foreign_key: :user_1_id

  has_many :potential_matches_as_user_2,
           class_name: "PotentialMatch",
           foreign_key: :user_2_id
  
  has_many :photos, dependent: :destroy
end