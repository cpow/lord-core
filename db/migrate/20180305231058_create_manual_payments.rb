class CreateManualPayments < ActiveRecord::Migration[5.1]
  def change
    create_table :manual_payments do |t|
      t.references :lease_payment, foreign_key: true
      t.integer :amount
      t.text :description

      t.timestamps
    end
  end
end
