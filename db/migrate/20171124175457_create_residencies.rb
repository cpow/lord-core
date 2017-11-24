class CreateResidencies < ActiveRecord::Migration[5.1]
  def change
    create_table :residencies do |t|
      t.integer :user_id
      t.integer :property_id
      t.integer :company_id
      t.integer :unit_id

      t.timestamps
    end

    add_index :residencies, :user_id
    add_index :residencies, :company_id
    add_index :residencies, :unit_id
    add_index :residencies, :property_id
  end
end
