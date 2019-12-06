FactoryBot.define do
  factory :damage_type do
    name { generate(:damage_type_name) }
    notes { "This item burns skin like acid." }
    user
  end

  sequence :damage_type_name do |n|
    "Acid#{n}"
  end
end
