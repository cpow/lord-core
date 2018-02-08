class AddStatusToIssues < ActiveRecord::Migration[5.1]
  def change
    add_column :issues, :status, :string, default: 'created'
  end
end
