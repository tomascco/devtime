class Hit < ApplicationRecord
  validates :timestamp, :language, :project, presence: true
end
