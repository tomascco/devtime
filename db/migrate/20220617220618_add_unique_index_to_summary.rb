class AddUniqueIndexToSummary < ActiveRecord::Migration[7.0]
  def change
    add_index :summaries, [:account_id, :day], unique: true
  end
end
