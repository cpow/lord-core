class CreateProperties < ActiveRecord::Migration[5.1]
  def change
    create_table :properties do |t|
      t.string :address_city, null: false
      t.string :address_line1, null: false
      t.string :address_state, null: false
      t.string :address_postal, null: false
      t.string :name, null: false
      t.text :description, null: false
      t.integer :company_id, null: false

      t.timestamps
    end
  end
end
