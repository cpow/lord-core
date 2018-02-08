class CreateIssues < ActiveRecord::Migration[5.1]
  def change
    create_table :issues do |t|
      t.references :property, foreign_key: true
      t.references :unit, foreign_key: true
      t.references :reporter, polymorphic: true
      t.text :description
      t.string :category

      t.timestamps
    end
  end
end
