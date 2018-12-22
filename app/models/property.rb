class Property < ApplicationRecord
  belongs_to :user, foreign_key: "user_id", optional: true
  
  extend FriendlyId
  friendly_id :name, use: :slugged

  enum view_status: { personal: 0,
                      homebrew: 1,
                      everyone: 2 }

  validates :name, presence: true,
                   length: { maximum: 25 },
                   uniqueness: { case_sensitive: false }

  validates :description, presence: true
end
