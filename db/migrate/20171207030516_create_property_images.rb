class CreatePropertyImages < ActiveRecord::Migration[5.1]
  def change
    create_table :property_images do |t|
      t.integer :property_id

      t.timestamps
    end
  end
end
