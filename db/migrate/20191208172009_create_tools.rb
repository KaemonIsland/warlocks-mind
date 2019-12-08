class CreateTools < ActiveRecord::Migration[5.2]
  def change
    create_table :tools do |t|
      t.integer :category
      t.string :name
      t.text :notes
      t.integer :cost_amount
      t.integer :cost_type
      t.integer :weight

      t.belongs_to :user, foreign_key: "user_id"

      t.timestamps
    end
  end
end
