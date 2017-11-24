class CreateUnits < ActiveRecord::Migration[5.1]
  def change
    create_table :units do |t|
      t.integer :property_id, null: false
      t.text :description
      t.string :name

      t.timestamps
    end
  end
end
