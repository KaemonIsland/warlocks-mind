class RemoveViewStatusFromWeapons < ActiveRecord::Migration[5.2]
  def change
    change_table :weapons do |t|
      t.remove :view_status
      t.rename :description, :notes
    end
    change_table :properties do |t|
      t.remove :view_status
      t.rename :description, :notes
    end
    change_table :damage_types do |t|
      t.remove :view_status
      t.rename :description, :notes
    end
  end
end
