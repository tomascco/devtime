require "test_helper"

class SummaryTest < ActiveSupport::TestCase
  test "must belongt to account" do
    summary = Summary.new(account: nil)

    refute summary.valid?
  end

  test ".empty" do
    summary = Summary.empty

    assert_equal summary.total_time, 0
  end
end
