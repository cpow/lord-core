class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.references :unit, foreign_key: true
      t.references :messageable, polymorphic: true, index: true

      t.text :body

      t.timestamps
    end
  end
end
