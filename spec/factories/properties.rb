FactoryBot.define do
  factory :property do
    view_status { 'personal' }
    name { generate(:name) }
    description { "A light weapon is small and easy to handle, making it ideal for use when fighting with two weapons." }
    user
  end

  sequence :name do |n|
    "Light#{n}"
  end
end
