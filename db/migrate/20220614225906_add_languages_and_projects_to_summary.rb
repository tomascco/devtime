class AddLanguagesAndProjectsToSummary < ActiveRecord::Migration[7.0]
  def change
    add_column :summaries, :languages, :jsonb
    add_index :summaries, :languages, using: :gin

    add_column :summaries, :projects, :jsonb
    add_index :summaries, :projects, using: :gin
  end
end
