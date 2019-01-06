class Weapon < ApplicationRecord
  belongs_to :user, optional: true
  
  before_save :capitalize
  after_initialize :set_defaults

  validates :name, presence: true,
                   length: { maximum: 25 }

  validates :category, presence: true,
                       inclusion: { in: ["simple_melee", "simple_ranged", "martial_melee", "martial_ranged"],
                       message: "%{value} is not a valid category" }

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

  validates :view_status, presence: true,
                          inclusion: { in: %w(personal homebrew everyone),
                          message: "%{value} is not a valid view status" }

  enum view_status: [:personal, :homebrew, :everyone]

  validates :description, presence: true,
                          allow_blank: true,
                          length: { maximum: 500 }

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
            user_id: user.id, 
            view_status: 'personal').or(Weapon.where(category: category, 
                                                     view_status: 'everyone')).order(:name)
    end
end
