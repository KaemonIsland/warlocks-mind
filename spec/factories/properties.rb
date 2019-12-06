FactoryBot.define do
  factory :property do
    name { generate(:property_name) }
    notes { "A light weapon is small and easy to handle, making it ideal for use when fighting with two weapons." }
    user
  end

  sequence :property_name do |n|
    "Light#{n}"
  end
end
