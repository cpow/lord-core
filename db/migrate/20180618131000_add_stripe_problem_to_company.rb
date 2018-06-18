class AddStripeProblemToCompany < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :stripe_problem, :boolean, default: false
  end
end
