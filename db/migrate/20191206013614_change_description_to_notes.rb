class ChangeDescriptionToNotes < ActiveRecord::Migration[5.2]
  def change
    change_table :weapon_feats do |t|
      t.rename :description, :notes
    end
  end
end
