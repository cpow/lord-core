class CreateCompanies < ActiveRecord::Migration[5.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :account_type
      t.string :stripe_account_guid

      t.timestamps
    end
  end
end
