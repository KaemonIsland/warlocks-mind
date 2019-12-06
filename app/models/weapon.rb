class Weapon < ApplicationRecord
  has_many :weapon_damage_types
  has_many :damage_types, through: :weapon_damage_types
  has_many :weapon_properties
  has_many :properties, through: :weapon_properties
  has_many :weapon_feats
  belongs_to :user, optional: true

  accepts_nested_attributes_for :weapon_damage_types, 
                                reject_if: lambda { |attr| attr['damage_type_id'].blank? },
                                allow_destroy: true

  accepts_nested_attributes_for :weapon_properties,
                                reject_if: lambda { |attr| attr['property_id'].blank? },
                                allow_destroy: true
  
  before_save :capitalize
  after_initialize :set_defaults

  validates :name, presence: true,
                   length: { maximum: 25 }

  validates :category, presence: true,
                       inclusion: { in: ["simple_melee", "simple_ranged", "martial_melee", "martial_ranged"],
                       message: "This is not a valid category" }

  enum category: [:simple_melee, :simple_ranged, :martial_melee, :martial_ranged]

  validates :cost_amount, 
            :weight, 
            :range_far, 
            :range_near, 
            :versatile_amount, 
            :versatile_die, presence: true,
                            allow_nil: true

  validates :cost_type, presence: true,
                        allow_nil: true,
                        inclusion: { in: %w(cp sp ep gp pp),
                        message: "%{value} is not a valid currency" }

  enum cost_type: [:cp, :sp, :ep, :gp, :pp]

  validates :damage_amount, 
            :damage_die, presence: true

  validates :notes, presence: true,
                          allow_blank: true,
                          length: { maximum: 500 }

  def remove(attr, id)
    case attr
    when "damage_types"
      self.weapon_damage_types_attributes = { id: id, _destroy: true }
    when "properties"
      self.weapon_properties_attributes = { id: id, _destroy: true }
    end
    self.save
  end

  private

    def set_defaults
      self.category ||= 'simple_melee'
      self.damage_amount ||= 1
      self.damage_die ||= 6
      self.modifier ||= 0
      self.cost_amount ||= 0
      self.cost_type ||= 'cp'
      self.weight ||= 1
    end

    #* Scopes

    def self.weapon_index(category, user)
      where(category: category, 
            user_id: user.id)
            .or(Weapon.where(category: category))
            .order(:name)
    end
end
