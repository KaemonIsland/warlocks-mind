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
    name: Faker::Name.unique.name,
    description: Faker::Lorem.sentences(5).join(' '),
    view_status: rand(2).even? ? 'personal' : 'everyone',
    user_id: rand(2).even? ? 1 : 2
  }
end

def create_property_damage(model)
  30.times do
  fake = return_stats()
  model.create!(
    name: fake[:name],
    description: fake[:description],
    view_status: fake[:view_status],
    user_id: fake[:user_id]
  )
  end
end

create_property_damage(Property)

puts "30 Properties Added"

create_property_damage(DamageType)


puts "30 Damage Types Added"

30.times do |weapon|
  category = rand 4

  Weapon.create!(
    name: Faker::Name.unique.name,
    category: rand(4),
    cost_amount: rand(20),
    cost_type: rand(5),
    damage_amount: 1,
    damage_die: 1 + rand(12),
    weight: 1 + rand(20),
    range_near: category == 1 || category == 3 ? rand(60) : nil,
    range_far: category == 1 || category == 3 ? rand(250) : nil,
    view_status: rand(2).even? ? 'personal' : 'everyone',
    description: Faker::Lorem.sentences(5).join(' '),
    modifier: 1 + rand(4),
    user_id: 1 + rand(2)
  )
  
end

puts "30 Weapons Added"
