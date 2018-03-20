class CreateManualPaymentReceipts < ActiveRecord::Migration[5.1]
  def change
    create_table :manual_payment_receipts do |t|
      t.references :manual_payment, foreign_key: true

      t.timestamps
    end
  end
end
