class AddLatestEventTypeToPayment < ActiveRecord::Migration[5.1]
  def change
    add_column :payments, :latest_event_type, :string
  end
end
