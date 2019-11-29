FactoryBot.define do
  factory :armor do
    name { 'Leather' }
    category { 'light' }
    cost_amount { 10 }
    cost_type { 'gp' }
    weight { 2 }
    notes { "This is a long piece of wood" }
    armor_class { 11 }
    armor_class_ability { 'dexterity' }
    armor_class_max { 2 }
    armor_class_modifier { '+2' }
    strength_requirement { 6 }
    stealth_disadvantage { false }
    don { 1 }
    don_time { 'minute' }
    doff { 1 }
    doff_time { 'minute' }
    user
  end
end
