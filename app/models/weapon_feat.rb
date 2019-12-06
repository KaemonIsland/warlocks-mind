class WeaponFeat < ApplicationRecord
  belongs_to :weapon

  validates :title, presence: true, length: { maximum: 255 }

  validates :notes, presence: true
end
