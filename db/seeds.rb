# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


require 'faker'
require 'open-uri'

puts 'Creating 50 fake users...'
User.destroy_all
50.times do
  user = User.new(
    username:    Faker::Name.last_name,
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: "123456",
  )
    photo_id = 1
    url = URI.open('https://source.unsplash.com/collection/people/250x250')
    user.photo.attach(io: url, filename: "#{photo_id}.png")
  user.save!
  photo_id += 1
end
puts 'Finished!'
