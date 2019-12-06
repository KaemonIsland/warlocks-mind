FactoryBot.define do
  factory :weapon do
    name { "Club" }
    category { 'simple_melee' }
    cost_amount { 1 }
    cost_type { 'sp' }
    damage_amount { 1 }
    damage_die { 4 }
    weight { 2 }
    range_near { nil }
    range_far { nil }
    versatile_amount { nil }
    versatile_die { nil }
    notes { "This is a long piece of wood" }
    modifier { 0 }
    user
  end
end
