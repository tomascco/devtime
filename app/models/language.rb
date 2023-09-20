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
class Language < ApplicationRecord
  validates :name, :hex_color, presence: true

  def self.all_in_hash
    all.pluck(:name, :hex_color).to_h
  end
end
