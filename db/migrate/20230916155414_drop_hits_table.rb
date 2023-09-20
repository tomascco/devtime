class DropHitsTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :hits
  end
end
