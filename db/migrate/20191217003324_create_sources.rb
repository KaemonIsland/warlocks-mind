class CreateSources < ActiveRecord::Migration[5.2]
  def change
    create_table :sources do |t|
      t.string :name

      t.belongs_to :user, foreign_key: "user_id"

      t.timestamps
    end
  end
end
