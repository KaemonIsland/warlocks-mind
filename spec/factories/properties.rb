FactoryBot.define do
  factory :property do
    view_status { 'personal' }
    name { "Light" }
    description { "A light weapon is small and easy to handle, making it ideal for use when fighting with two weapons." }
    user
  end
end
