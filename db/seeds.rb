# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(
  name: 'Kaemon Lovendahl',
  email: 'k-manskrazy@hotmail.com',
  password: 'password',
  password_confirmation: 'password',
  admin: true
)

15.times do
  name = Faker::Name.name
  email = Faker::Internet.unique.email
  password = "password"
  User.create!(
    name: name,
    email: email,
    password: password,
    password_confirmation: password
  )
end

puts "16 Users created"

def return_stats()
  {
    name: Faker::Pokemon.unique.name,
    description: Faker::Lorem.sentences(5).join(' '),
    view_status: Faker::Number.number(2).to_i.even? ? 'personal' : 'everyone',
    user_id: Faker::Number.number(2).to_i.even? ? 1 : 2
  }
end

30.times do
  fake = return_stats()
  Property.create!(
    name: fake[:name],
    description: fake[:description],
    view_status: fake[:view_status],
    user_id: fake[:user_id]
  )
end
  
puts "30 Properties Added"