class AddPaymentIdToLease < ActiveRecord::Migration[5.1]
  def change
    add_column :leases, :payment_id, :integer
    add_index :leases, :payment_id
  end
end
