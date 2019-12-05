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

def return_stats(name)
  {
    name: name,
    description: Faker::Lorem.sentences(number: 5).join(' '),
    view_status: rand(2).even? ? 'personal' : 'everyone',
    user_id: rand(2).even? ? 1 : 2
  }
end

def create_property_damage(model, names_arr)
  names_arr.length.times do |i|
  fake = return_stats(names_arr[i])
  model.create!(
    name: fake[:name],
    description: fake[:description],
    view_status: fake[:view_status],
    user_id: fake[:user_id]
  )
  end
end

property_names = [
  'Ammuntion',
  'Finesse',
  'Heavy',
  'Light',
  'Loading',
  'Range',
  'Reach',
  'Special',
  'Thrown',
  'Two-Handed',
  'Versatile'
]

create_property_damage(Property, property_names)

puts "Weapon Properties Added"

damage_names = [
  'Acid',
  'Bludgeoning',
  'Cold',
  'Fire',
  'Force',
  'Lightning',
  'Necrotic',
  'Piercing',
  'Poison',
  'Psychic',
  'Radiant',
  'Slashing',
  'Thunder'
]

create_property_damage(DamageType, damage_names)


puts "Damage Types Added"

weapon_names = [
  {
    category: 'simple_melee',
    names: [
      'Club',
      'Dagger',
      'Greatclub',
      'Handaxe',
      'Javelin',
      'Light Hammer',
      'Mace',
      'Quarterstaff',
      'Sickle',
      'Spear'
    ]
  },
  {
    category: 'simple_ranged',
    names: [
      'Light Crossbow',
      'Dart',
      'Shortbow',
      'Sling'
    ]
  },
  {
    category: 'martial_melee',
    names: [
      'Battleaxe',
      'Flail',
      'Glaive',
      'Greataxe',
      'Halberd',
      'Lance',
      'Longsword',
      'Maul',
      'Morningstar',
      'Pike',
      'Rapier',
      'Scimitar',
      'Shortsword',
      'Trident',
      'War Pick',
      'Warhammer',
      'Whip'
    ]
  },
  {
    category: 'martial_ranged',
    names: [
      'Blowgun',
      'Hand Crossbow',
      'Heavy Crossbow',
      'Longbow',
      'Net'
    ]
  }
]

weapon_names.each do |category:, names:|

  names.each do |name|

    Weapon.create!(
      name: name,
      category: category,
      cost_amount: rand(20),
      cost_type: rand(5),
      damage_amount: 1,
      damage_die: 1 + rand(12),
      weight: 1 + rand(20),
      range_near: category == 1 || category == 3 ? rand(60) : nil,
      range_far: category == 1 || category == 3 ? rand(250) : nil,
      view_status: rand(2).even? ? 'personal' : 'everyone',
      description: Faker::Lorem.sentences(number: 5).join(' '),
      modifier: 1 + rand(4),
      user_id: 1 + rand(2)
    )
  end
end

puts "Weapons Added"

armor_names = [
  {
    category: 'light',
    names: [
      'Padded',
      'Leather',
      'Studded Leather'
    ]
  },
  {
    category: 'medium',
    names: [
      'Hide',
      'Chain Shirt',
      'Scale Mail',
      'Breastplate',
      'Half Plate'
    ]
  },
  {
    category: 'heavy',
    names: [
      'Ring Mail',
      'Chain Mail',
      'Splint',
      'Plate'
    ]
  },
  {
    category: 'shield',
    names: ['shield']
  }
]

armor_names.each do |category:, names:|

  names.each do |name|

    Armor.create!(
      name: name,
      category: category,
      armor_class: rand(6) + 10,
      armor_class_ability: rand(6),
      armor_class_max: rand(2),
      armor_class_modifier: rand(2),
      strength_requirement: rand(2).positive? ? rand(15) : '',
      stealth_disadvantage: rand(2).positive?,
      don: rand(10),
      don_time: %w(minute hour action bonus_action instant).sample,
      doff: rand(10),
      doff_time: %w(minute hour action bonus_action instant).sample,
      cost_amount: rand(20),
      cost_type: rand(5),
      weight: 1 + rand(20),
      notes: Faker::Lorem.sentences(number: 5).join(' '),
      user_id: 1 + rand(2)
    )
  end
end

puts "Armor Added"

gear_names = [
  {
    category: 'general',
    names: [
      'Abacus',
      'Alchemists Fire',
      'Acid',
      'Backpack'
    ]
  },
  {
    category: 'ammunition',
    names: [
      'Arrows',
      'Blowgun Needles',
      'Crossbow Bolts',
      'Sling Bullets'
    ]
  },
  {
    category: 'arcane_focus',
    names: [
      'Crystal',
      'Orb',
      'Rod',
      'Staff',
      'Wand'
    ]
  },
  {
    category: 'druidic_focus',
    names: [
      'Sprig of Mistletoe',
      'Totem',
      'Wooden Staff',
      'Yew Wand'
    ]
  },
  {
    category: 'holy_symbol',
    names: [
      'Amulet',
      'Emblem',
      'Reliquary'
    ]
  }
]

gear_names.each do |category:, names:|

  names.each do |name|
    Gear.create!(
      name: name,
      category: category,
      cost_amount: rand(20),
      cost_type: rand(5),
      weight: 1 + rand(20),
      notes: Faker::Lorem.sentences(number: 5).join(' '),
      user_id: 1 + rand(2)
    )
  end
end

puts 'Gear added'
