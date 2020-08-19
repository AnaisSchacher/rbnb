# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


require 'faker'
require 'open-uri'

Profile.destroy_all
User.destroy_all
puts "Deleting all users..."

puts 'Creating 6 fake users...'

5.times do  
  user = User.new(
    username: Faker::Name.last_name,
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: "123456",
  )

  puts "user_created"
  file = URI.open('https://source.unsplash.com/collection/people/250x250')
  puts "url_defined"
  user.photo.attach(io: file, filename: 'user.png', content_type: 'image/png')
  puts "photo_attached"
  # binding.pry
  user.save!
  puts "user_saved"
end
# TEST SEED POUR LA DEMO

usertest = User.new(
  username: "giloudestropiques",
  name: "Gilbert Montagné",
  email: "gilou@gmail.com",
  password: "123456",
)

puts "usertest_created"
file = URI.open('https://l1visible.com/wp-content/uploads/2011/10/gilbert-montagne-1170x776')
puts "url_defined"
usertest.photo.attach(io: file, filename: 'user.png', content_type: 'image/png')
puts "photo_attached"
# binding.pry
usertest.save!
puts "usertest_saved"


puts "Deleting all profiles..."

puts 'Creating 4 fake profiles...'
3.times do
  profile = Profile.new(
    user: User.take,
    address: Faker::Address.street_address,
    available: true,
    category: [ "Handicap mental", "Handicap sensoriel", "Handicap moteur", "Handicap psychique", "Maladies invalidantes" ].sample,
    price: Faker::Number.between(from: 10, to: 30),
    description: Faker::Lorem.paragraph(sentence_count: 4)
  )
  puts "profiletest_created"
  profile.save!
  puts "profiletest_saved"
end
# TEST SEED POUR LA DEMO
profiletest = Profile.new(
    user: User.last,
    address: "16 villa Gaudelet, Paris, France",
    available: true,
    category: "Malvoyant",
    price: Faker::Number.between(from: 10, to: 30),
    description: Faker::Lorem.paragraph(sentence_count: 4),
  )
  puts "profiletest_created"
  profiletest.save!
  puts "profiletest_saved"

puts 'Finished!'
