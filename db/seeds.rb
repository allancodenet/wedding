require "open-uri"
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Seed a User

client1 = User.create!(
  email: "client@client.com",
  password: "password",
  role: :client
)
client2 = User.create!(
  email: "client2@client.com",
  password: "password",
  role: :client
)

user1 = User.create!(
  email: "provider@provider.com",
  password: "password",
  role: :provider
)

user2 = User.create!(
  email: "provider2@provider.com",
  password: "password",
  role: :provider
)

# Create porovider with images
5.times do
  provider = Provider.new(
    user: user1,
    name: Faker::Company.name,
    description: Faker::Lorem.paragraphs(number: 5).join("\n\n"),
    motto: Faker::Lorem.sentence,
    location: Faker::Address.city,
    service: Provider.services.keys.sample
  )

  # Attach images to the provider
  5.times do
    image_url = Faker::LoremFlickr.image(size: "1400x800", search_terms: ["nature", "landscape"])
    image = URI.open(image_url)
    provider.images.attach(io: image, filename: "#{Faker::Alphanumeric.alpha(number: 10)}.jpg")
  end
  provider.save!
end

5.times do
  provider = Provider.new(
    user: user2,
    name: Faker::Company.name,
    description: Faker::Lorem.paragraphs(number: 5).join("\n\n"),
    motto: Faker::Lorem.sentence,
    location: Faker::Address.city,
    service: Provider.services.keys.sample
  )

  # Attach images to the provider
  5.times do
    image_url = Faker::LoremFlickr.image(size: "1400x800", search_terms: ["wedding"])
    image = URI.open(image_url)
    provider.images.attach(io: image, filename: "#{Faker::Alphanumeric.alpha(number: 10)}.jpg")
  end
  provider.save!
end

Client.create!(
  user: client1,
  name: "Leilani",
  location: "Kikuyu",
  wedding_date: Faker::Time.between(from: DateTime.now, to: 1.year.from_now),
  budget: 100000,
  guest_no: 300
)
Client.create!(
  user: client2,
  name: "Vista",
  location: "Nairobi",
  wedding_date: Faker::Time.between(from: DateTime.now, to: 1.year.from_now),
  budget: 500000,
  guest_no: 500
)
