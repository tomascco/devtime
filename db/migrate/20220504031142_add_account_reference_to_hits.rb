class AddAccountReferenceToHits < ActiveRecord::Migration[7.0]
  def change
    add_reference :hits, :account, null: false, foreign_key: true
  end
end
