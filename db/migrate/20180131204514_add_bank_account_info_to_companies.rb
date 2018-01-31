class AddBankAccountInfoToCompanies < ActiveRecord::Migration[5.1]
  def change
    add_column :companies, :bank_account_name, :string
    add_column :companies, :bank_account_last4, :string
  end
end
