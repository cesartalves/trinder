# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

users = [
  {
    name: "Ava",
    email: "ava@example.com",
    password: "password",
    description: "Loves hiking, coffee shops, and weekend road trips."
  },
  {
    name: "Milo",
    email: "milo@example.com",
    password: "password",
    description: "Tech enthusiast who enjoys cooking and local music scenes."
  },
  {
    name: "Sofia",
    email: "sofia@example.com",
    password: "password",
    description: "Book lover and yoga fan seeking good conversation."
  },
  {
    name: "Noah",
    email: "noah@example.com",
    password: "password",
    description: "Enjoys photography, hiking, and trying new restaurants."
  },
  {
    name: "Luna",
    email: "luna@example.com",
    password: "password",
    description: "Creative soul who loves art galleries and weekend markets."
  },
  {
    name: "Eli",
    email: "eli@example.com",
    password: "password",
    description: "Music fan and amateur chef always up for a new adventure."
  },
  {
    name: "Maya",
    email: "maya@example.com",
    password: "password",
    description: "Nature lover who enjoys biking, art, and quiet cafés."
  },
  {
    name: "Leo",
    email: "leo@example.com",
    password: "password",
    description: "Fitness buff with a passion for travel and street photography."
  },
  {
    name: "Zoe",
    email: "zoe@example.com",
    password: "password",
    description: "Social butterfly who enjoys dancing, cooking, and good books."
  },
  {
    name: "Kai",
    email: "kai@example.com",
    password: "password",
    description: "Weekend surfer and board game enthusiast seeking connection."
  }
]

users.each do |user_attrs|
  user = User.find_or_initialize_by(email: user_attrs[:email])
  user.assign_attributes(user_attrs)
  user.save!
end
