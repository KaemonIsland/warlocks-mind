class CreateWeapons < ActiveRecord::Migration[5.2]
  def change
    create_table :weapons do |t|
      t.string :name
      t.integer :category
      t.integer :cost_amount
      t.integer :cost_type
      t.integer :damage_amount
      t.integer :damage_die
      t.integer :weight
      t.integer :range_near
      t.integer :range_far
      t.integer :view_status, default: 0
      t.integer :versatile_amount
      t.integer :versatile_die
      t.string :description
      t.integer :modifier

      t.belongs_to :user, foreign_key: "user_id"

      t.timestamps
    end
  end
end
