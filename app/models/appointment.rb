class Appointment < ApplicationRecord
  belongs_to :account
  belongs_to :appointment_kind
end
