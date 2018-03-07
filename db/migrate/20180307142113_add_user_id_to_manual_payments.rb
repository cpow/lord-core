class AddUserIdToManualPayments < ActiveRecord::Migration[5.1]
  def change
    add_reference :manual_payments, :user, foreign_key: true
  end
end
