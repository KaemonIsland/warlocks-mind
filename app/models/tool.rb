class Tool < ApplicationRecord
  belongs_to :user

  after_initialize :set_defaults

  validates :name, presence: true

  validates :category, presence: true,
  inclusion: { in: %w(general artisan_tool gaming_set musical_instrument),
  message: "%{value} is not a valid tool" }

  enum category: [
    :general,
    :artisan_tool,
    :gaming_set,
    :musical_instrument
  ]

  validates :cost_type, presence: true,
  allow_nil: true,
  inclusion: { in: %w(cp sp ep gp pp),
  message: "%{value} is not a valid currency" }

  enum cost_type: [
    :cp,
    :sp,
    :ep,
    :gp,
    :pp
  ]

  def set_defaults
    self.category ||= 'general'
  end

  def self.user_tools user_id
    where(user_id: user_id)
  end
end
