class AddLocalAmountToLeasePayment < ActiveRecord::Migration[5.1]
  def change
    add_column :lease_payments, :local_amount, :integer, default: nil
  end
end
