class AddSourceIdToOtherModels < ActiveRecord::Migration[5.2]
  def change
    add_reference :gears, :sources, index: true
    add_reference :weapons, :sources, index: true
    add_reference :armors, :sources, index: true
    add_reference :properties, :sources, index: true
    add_reference :damage_types, :sources, index: true
    add_reference :tools, :sources, index: true
  end
end
