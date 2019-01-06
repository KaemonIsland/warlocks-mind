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
    view_status { 'personal' }
    versatile_amount { nil }
    versatile_die { nil }
    description { "This is a long piece of wood" }
    modifier { 0 }
  end
end
