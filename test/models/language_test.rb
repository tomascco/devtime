# == Schema Information
#
# Table name: languages
#
#  id         :bigint           not null, primary key
#  hex_color  :string           not null
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
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

  test ".all_in_hash" do
    Language.insert_all([
      {name: "ruby", hex_color: "fff"},
      {name: "html", hex_color: "000"}
    ])

    languages_hash = Language.all_in_hash

    assert_equal languages_hash, {
      "ruby" => "fff",
      "html" => "000"
    }
  end
end
