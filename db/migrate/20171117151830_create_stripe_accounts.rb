class CreateStripeAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :stripe_accounts do |t|
      t.string :first_name
      t.string :last_name
      t.string :account_type
      t.string :dob_month
      t.string :dob_day
      t.string :dob_year
      t.string :address_city
      t.string :address_state
      t.string :address_line1
      t.string :address_postal
      t.boolean :tos, default: false
      t.string :ssn_last_4
      t.string :business_name
      t.string :business_tax_id
      t.string :business_id_number
      t.string :verification_document

      t.string :stripe_account_guid

      t.timestamps
    end
  end
end
