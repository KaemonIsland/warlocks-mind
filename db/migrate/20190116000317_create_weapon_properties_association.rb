class CreateWeaponPropertiesAssociation < ActiveRecord::Migration[5.2]
  def change
    create_table :weapon_properties do |t|
      t.belongs_to :weapon, index: true
      t.belongs_to :property, index: true
      
      t.timestamps
    end
  end
end
