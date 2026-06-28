class PotentialMatch < ApplicationRecord
  belongs_to :user_1, class_name: "User"
  belongs_to :user_2, class_name: "User"
  belongs_to :liked_by, class_name: "User", optional: true
  belongs_to :match, optional: true

  enum :state, {
    declined: "declined",
    potential: "potential",
    liked: "liked",
    matched: "matched"
  }
end