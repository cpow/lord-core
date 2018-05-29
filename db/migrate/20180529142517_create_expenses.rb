class CreateExpenses < ActiveRecord::Migration[5.1]
  def change
    create_table :expenses do |t|
      t.integer :amount
      t.text :description
      t.references :expenseable, polymorphic: true, index: true
      t.references :company, index: true

      t.timestamps
    end
  end
end
