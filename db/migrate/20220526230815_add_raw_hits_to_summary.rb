class AddRawHitsToSummary < ActiveRecord::Migration[7.0]
  def change
    add_column :summaries, :raw_hits, :jsonb
    add_index :summaries, :raw_hits, using: :gin
  end
end
