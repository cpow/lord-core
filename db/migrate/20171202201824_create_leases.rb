class CreateLeases < ActiveRecord::Migration[5.1]
  def change
    create_table :leases do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.datetime :payment_first_date
      t.integer :payment_amount
      t.integer :payment_days_until_late
      t.integer :payment_reminder_days
      t.integer :unit_id

      t.timestamps
    end
  end
end
