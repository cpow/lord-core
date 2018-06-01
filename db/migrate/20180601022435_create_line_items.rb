class CreateLineItems < ActiveRecord::Migration[5.2]
  def change
    create_table :line_items do |t|
      t.references :itemable, polymorphic: true
      t.references :company, foreign_key: true, index: true

      t.timestamps
    end
  end
end
