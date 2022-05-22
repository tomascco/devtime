class CreateSummaries < ActiveRecord::Migration[7.0]
  def change
    create_table :summaries do |t|
      t.date :day, null: false
      t.interval :total_time, null: false, default: 0
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
