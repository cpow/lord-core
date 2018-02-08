class CreateIssueImages < ActiveRecord::Migration[5.1]
  def change
    create_table :issue_images do |t|
      t.references :issue, foreign_key: true

      t.timestamps
    end
  end
end
