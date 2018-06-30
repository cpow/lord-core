class AddInviteTokenToPropertyManagers < ActiveRecord::Migration[5.2]
  def change
    add_column :property_managers, :invite_token, :string
    add_column :property_managers, :invited_by_id, :integer
    add_column :property_managers, :invite_date, :date
  end
end
