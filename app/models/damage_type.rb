class DamageType < ApplicationRecord
  belongs_to :user, foreign_key: "user_id", optional: true
  has_many :weapon_damage_types
  has_many :weapons, through: :weapon_damage_types
  before_save :capitalize

  extend FriendlyId
  friendly_id :name, use: :slugged

  validates :name, presence: true,
                   length: { maximum: 25 },
                   uniqueness: { case_sensitive: false }

  validates :notes, presence: true

  private
    #Scopes
    def self.viewable_damage_types(user)
      where(user_id: user.id).order(:name)
    end
end
