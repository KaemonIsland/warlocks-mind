class Gear < ApplicationRecord
  belongs_to :user
  before_save :capitalize

  validates :name, presence: true,  length: { maximum: 255 }

  validates :category, presence: true,
  allow_nil: true,
  inclusion: { in: %w(general ammunition arcane_focus druidic_focus holy_symbol),
  message: "is not a valid gear category" }

  enum category: [
    :general,
    :ammunition,
    :arcane_focus,
    :druidic_focus,
    :holy_symbol
  ]

  validates :cost_type, presence: true,
  allow_nil: true,
  inclusion: { in: %w(cp sp ep gp pp),
  message: "is not a valid currency" }

  enum cost_type: [
    :cp,
    :sp,
    :ep,
    :gp,
    :pp
  ]
end
