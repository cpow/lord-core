class CreateLeasePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :lease_payments do |t|
      t.integer :unit_id, null: false
      t.integer :lease_id, null: false
      t.datetime :due_date
      t.datetime :reminder_date
      t.datetime :past_due_date
      t.boolean :active, default: false

      t.timestamps
    end
  end
end
