class AddPropertyToEvents < ActiveRecord::Migration[5.1]
  def change
    add_reference :events, :property, index: true
    add_column :events, :read, :boolean, default: false

    add_index :events, :read
  end
end
