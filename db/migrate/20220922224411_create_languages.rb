class CreateLanguages < ActiveRecord::Migration[7.0]
  def change
    create_table :languages do |t|
      t.string :names, array: true, null: false
      t.string :hex_color, null: false

      t.timestamps
    end
  end
end
