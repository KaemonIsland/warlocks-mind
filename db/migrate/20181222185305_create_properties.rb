class CreateProperties < ActiveRecord::Migration[5.2]
  def change
    create_table :properties do |t|
      t.integer :view_status, default: 0
      t.string :name
      t.text :description

      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
