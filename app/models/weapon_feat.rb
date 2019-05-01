class WeaponFeat < ApplicationRecord
  belongs_to :weapon

  validates :title, presence: true

  validates :description, presence: true
end
