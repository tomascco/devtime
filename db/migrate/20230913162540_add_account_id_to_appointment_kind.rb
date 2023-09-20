class AddAccountIdToAppointmentKind < ActiveRecord::Migration[7.0]
  def change
    add_reference :appointment_kinds, :account, null: false, foreign_key: true
  end
end
