class CreateGears < ActiveRecord::Migration[5.2]
  def change
    create_table :gears do |t|
      t.string :name
      t.integer :category
      t.integer :cost_amount
      t.integer :cost_type
      t.integer :weight
      t.string :notes

      t.belongs_to :user, foreign_key: "user_id"

      t.timestamps
    end
  end
end
