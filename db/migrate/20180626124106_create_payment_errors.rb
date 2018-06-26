class CreatePaymentErrors < ActiveRecord::Migration[5.2]
  def change
    create_table :payment_errors do |t|
      t.text :error_message
      t.integer :amount
      t.references :property, foreign_key: true
      t.references :unit, foreign_key: true
      t.references :lease, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
