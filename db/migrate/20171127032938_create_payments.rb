class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
      t.integer :amount
      t.integer :amount_refunded
      t.integer :unit_id
      t.integer :user_id

      t.timestamps
    end
  end
end
