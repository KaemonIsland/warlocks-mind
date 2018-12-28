FactoryBot.define do
  factory :damage_type do
    view_status { "personal" }
    name { generate(:damage_type_name) }
    description { "This item burns skin like acid." }
    user
  end

  sequence :damage_type_name do |n|
    "Acid#{n}"
  end
end
