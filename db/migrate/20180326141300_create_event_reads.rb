class CreateEventReads < ActiveRecord::Migration[5.1]
  def change
    create_table :event_reads do |t|
      t.references :reader, polymorphic: true, index: true
      t.references :event, index: true
    end
  end
end
