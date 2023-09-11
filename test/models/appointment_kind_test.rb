# == Schema Information
#
# Table name: appointment_kinds
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_appointment_kinds_on_name  (name) UNIQUE
#
require "test_helper"

class AppointmentKindTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
