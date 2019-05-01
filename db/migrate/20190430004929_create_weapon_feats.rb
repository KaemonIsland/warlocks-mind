class CreateWeaponFeats < ActiveRecord::Migration[5.2]
  def change
    create_table :weapon_feats do |t|
      t.string :title
      t.string :description
      t.belongs_to :weapon, index: true

      t.timestamps
    end
  end
end
