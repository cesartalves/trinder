class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, 
         :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :potential_matches_as_user_1,
           class_name: "PotentialMatch",
           foreign_key: :user_1_id

  has_many :potential_matches_as_user_2,
           class_name: "PotentialMatch",
           foreign_key: :user_2_id
  
  has_many :photos, dependent: :destroy

  def self.from_google(auth)
    user = find_by(provider: auth.provider, uid: auth.uid)

    return user if user

    user = find_by(email: auth.info.email)

    if user
      user.update!(
        provider: auth.provider,
        uid: auth.uid
      )
      return user
    end

    create!(
      provider: auth.provider,
      uid: auth.uid,
      email: auth.info.email,
      name: auth.info.name,
      password: Devise.friendly_token[0, 20]
    )
  end
end