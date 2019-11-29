class Armor < ApplicationRecord
  belongs_to :user, optional: true

  before_save :capitalize

  validates :name, presence: true, length: { maximum: 255 }

  validates :category,
            presence: true,
            inclusion: {
              in: %w(heavy medium light shield),
              message: "this is not a valid category"
            }

  enum category: [:heavy, :medium, :light, :shield]

  validates :armor_class_ability,
            presence: true,
            allow_nil: true,
            inclusion: {
              in: %w(strength dexterity constitution intellect wisdom charisma),
              message: "this is not a valid category"
            }

  enum armor_class_ability: [
    :strength,
    :dexterity,
    :constitution,
    :intellect,
    :wisdom,
    :charisma
  ]

  validates :cost_type, presence: true,
  allow_nil: true,
  inclusion: {
    in: %w(cp sp ep gp pp),
    message: "This is not a valid currency"
  }

  enum cost_type: [:cp, :sp, :ep, :gp, :pp]
end
