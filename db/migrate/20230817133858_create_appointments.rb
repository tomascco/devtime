class CreateAppointments < ActiveRecord::Migration[7.0]
  def change
    create_table :appointments do |t|
      t.references :account, null: false, foreign_key: true
      t.tstzrange :time_range
      t.references :appointment_kind, null: false, foreign_key: true
      t.text :comment

      t.timestamps
    end
  end
end
