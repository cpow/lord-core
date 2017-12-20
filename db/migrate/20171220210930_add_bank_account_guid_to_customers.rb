class AddBankAccountGuidToCustomers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :bank_account_guid, :string
    add_column :users, :bank_account_last4, :string
    add_column :users, :bank_account_name, :string
  end
end
