class CreateChargeEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :charge_events do |t|
      t.string :stripe_charge_id
      t.string :event_type
      t.string :stripe_event_id
      t.string :failure_code
      t.string :failure_message
      t.integer :payment_id

      t.timestamps
    end

    add_index :charge_events, :payment_id
  end
end
