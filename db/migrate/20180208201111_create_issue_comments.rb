class CreateIssueComments < ActiveRecord::Migration[5.1]
  def change
    create_table :issue_comments do |t|
      t.references :issue, foreign_key: true
      t.references :commentable, polymorphic: true
      t.text :body

      t.timestamps
    end
  end
end
