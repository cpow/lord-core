class AddActiveToResidencies < ActiveRecord::Migration[5.1]
  def change
    add_column :residencies, :active, :boolean, defualt: true
    add_index :residencies, :active
  end
end
