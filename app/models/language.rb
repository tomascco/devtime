class Language < ApplicationRecord
  validates :name, :hex_color, presence: true
end
