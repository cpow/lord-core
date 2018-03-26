class AddUnitIdToEvents < ActiveRecord::Migration[5.1]
  def change
    add_reference :events, :unit, index: true
  end
end
