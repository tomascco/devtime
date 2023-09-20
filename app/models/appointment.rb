# == Schema Information
#
# Table name: appointments
#
#  id                  :bigint           not null, primary key
#  comment             :text
#  time_range          :tstzrange
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  account_id          :bigint           not null
#  appointment_kind_id :bigint           not null
#
# Indexes
#
#  index_appointments_on_account_id           (account_id)
#  index_appointments_on_appointment_kind_id  (appointment_kind_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (appointment_kind_id => appointment_kinds.id)
#
class Appointment < ApplicationRecord
  belongs_to :account
  belongs_to :appointment_kind

  attribute :time_range_start, :datetime
  attribute :time_range_end, :datetime

  validates :time_range, presence: true

  def duration
    time_range.end - time_range.begin
  end
end
