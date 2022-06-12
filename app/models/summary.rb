class Summary < ApplicationRecord
  belongs_to :account

  def self.empty
    Summary.new(total_time: 0)
  end
end
