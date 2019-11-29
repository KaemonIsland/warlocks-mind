class CreateArmors < ActiveRecord::Migration[5.2]
  def change
    create_table :armors do |t|
      t.string :name
      t.integer :category
      t.integer :armor_class
      t.integer :armor_class_ability
      t.integer :armor_class_max
      t.string :armor_class_modifier
      t.integer :strength_requirement
      t.boolean :stealth_disadvantage
      t.integer :cost_amount
      t.integer :cost_type
      t.string :notes
      t.integer :weight
      t.integer :don
      t.string :don_time
      t.integer :doff
      t.string :doff_time

      t.belongs_to :user, foreign_key: "user_id"

      t.timestamps
    end
  end
end
