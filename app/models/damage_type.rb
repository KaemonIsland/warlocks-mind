class DamageType < ApplicationRecord
  belongs_to :user, foreign_key: "user_id", optional: true
  has_many :weapon_damage_types
  has_many :weapons, through: :weapon_damage_types
  before_save :capitalize

  extend FriendlyId
  friendly_id :name, use: :slugged

  enum view_status: { personal: 0,
                      homebrew: 1,
                      everyone: 2 }

  validates :name, presence: true,
                   length: { maximum: 25 },
                   uniqueness: { case_sensitive: false }

  validates :description, presence: true

  private
    #Scopes
    def self.viewable_damage_types(user)
      where(view_status: 'personal', user_id: user.id).or(DamageType.where(view_status: 'everyone')).order(:name)
    end
end
