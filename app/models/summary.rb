# == Schema Information
#
# Table name: summaries
#
#  id         :bigint           not null, primary key
#  day        :date             not null
#  languages  :jsonb
#  projects   :jsonb
#  raw_hits   :jsonb
#  total_time :interval         default(0 seconds), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  account_id :bigint           not null
#
# Indexes
#
#  index_summaries_on_account_id          (account_id)
#  index_summaries_on_account_id_and_day  (account_id,day) UNIQUE
#  index_summaries_on_languages           (languages) USING gin
#  index_summaries_on_projects            (projects) USING gin
#  index_summaries_on_raw_hits            (raw_hits) USING gin
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
class Summary < ApplicationRecord
  belongs_to :account

  def self.empty
    Summary.new(total_time: 0)
  end
end
