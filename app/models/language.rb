class Language < ApplicationRecord
  validates :name, :hex_color, presence: true

  def self.all_in_hash
    all.pluck(:name, :hex_color).to_h
  end
end
