class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  def capitalize
    name.capitalize!
  end
end