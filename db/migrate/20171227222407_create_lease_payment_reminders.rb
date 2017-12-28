class CreateLeasePaymentReminders < ActiveRecord::Migration[5.1]
  def change
    create_table :lease_payment_reminders do |t|
      t.text :email_text
      t.string :reminder_type, null: false
      t.integer :lease_payment_id, null: false

      t.timestamps
    end
  end
end
