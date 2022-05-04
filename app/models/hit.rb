class Hit < ApplicationRecord
  validates :timestamp, :language, :project, presence: true
  belongs_to :account
end
