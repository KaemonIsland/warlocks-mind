FactoryBot.define do
  factory :tool do
    category { 1 }
    name { "MyString" }
    notes { "MyText" }
    cost_amount { 1 }
    cost_type { 1 }
    weight { 1 }
    source { 1 }
  end
end
