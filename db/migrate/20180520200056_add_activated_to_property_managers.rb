class AddActivatedToPropertyManagers < ActiveRecord::Migration[5.1]
  def change
    add_column :property_managers, :active, :boolean, defualt: true
    add_index :property_managers, :active
  end
end
