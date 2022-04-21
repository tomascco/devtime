class CreateHits < ActiveRecord::Migration[7.0]
  def change
    create_table :hits do |t|
      t.timestamp :timestamp
      t.string :language
      t.string :project

      t.timestamps
    end
  end
end
