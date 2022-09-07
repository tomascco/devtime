require "test_helper"

class HitTest < ActiveSupport::TestCase
  test "must have language, project and timestamp" do
    hit = Hit.new({
      "project" => "test",
      "timestamp" => "2022-09-07 16:02:42 UTC",
      "language" => "ruby"
    })

    assert hit.valid?
  end

  test "invalid without language" do
    hit = Hit.new({
      "project" => "test",
      "timestamp" => "2022-09-07 16:02:42 UTC"
    })

    refute hit.valid?
  end

  test "invalid without project" do
    hit = Hit.new({
      "language" => "ruby",
      "timestamp" => "2022-09-07 16:02:42 UTC"
    })

    refute hit.valid?
  end

  test "invalid without timestamp" do
    hit = Hit.new({
      "project" => "test",
      "language" => "ruby"
    })

    refute hit.valid?
  end

  test "#to_json" do
    hit = Hit.new({
      "project" => "test",
      "timestamp" => "2022-09-07 16:02:42 UTC",
      "language" => "ruby"
    })

    assert_equal hit.to_json, {
      version: 1,
      timestamp: Time.parse("2022-09-07 16:02:42 UTC"),
      language: "ruby",
      project: "test"
    }.to_json
  end
end
