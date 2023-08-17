require "open-uri"
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Seed a User

user = User.create!(
  email: "provider@provider.com",
  password: "password",
  role: :provider
)

# Create porovider with images
5.times do
  provider = Provider.new(
    user: user,
    name: Faker::Company.name,
    description: Faker::Lorem.paragraphs(number: 5).join("\n\n"),
    motto: Faker::Lorem.sentence,
    location: Faker::Address.city,
    service: :venue
  )

  # Attach images to the provider
  5.times do
    image_url = Faker::LoremFlickr.image(size: "1400x800", search_terms: ["nature", "landscape"])
    image = URI.open(image_url)
    provider.images.attach(io: image, filename: "#{Faker::Alphanumeric.alpha(number: 10)}.jpg")
  end
  provider.save!
end
