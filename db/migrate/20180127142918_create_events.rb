class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.references :eventable, polymorphic: true
      t.string :event_type
      t.jsonb :serialized_changes
      t.string :object_type
      t.jsonb :serialized_record
      t.references :createable, polymorphic: true

      t.timestamps
    end
  end
end
