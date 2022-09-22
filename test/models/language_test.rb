require "test_helper"

class LanguageTest < ActiveSupport::TestCase
  test "must require hex_color" do
    language = Language.new(name: "ruby", hex_color: nil)

    refute language.valid?
  end

  test "must require name" do
    language = Language.new(name: nil, hex_color: "fff")

    refute language.valid?
  end
end
