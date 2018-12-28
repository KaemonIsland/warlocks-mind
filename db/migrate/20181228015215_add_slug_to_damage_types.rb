class AddSlugToDamageTypes < ActiveRecord::Migration[5.2]
  def change
    add_column :damage_types, :slug, :string
    add_index :damage_types, :slug, unique: true
  end
end
