FactoryBot.define do
  factory :gear do
    name { "abacus" }
    category { nil }
    cost_amount { 2 }
    cost_type { 'gp' }
    weight { 2 }
    notes { "Helps you do the maths" }
    user
  end
end
