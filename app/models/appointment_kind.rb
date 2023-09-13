# == Schema Information
#
# Table name: appointment_kinds
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  account_id :bigint           not null
#
# Indexes
#
#  index_appointment_kinds_on_account_id  (account_id)
#  index_appointment_kinds_on_name        (name) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
class AppointmentKind < ApplicationRecord
end
