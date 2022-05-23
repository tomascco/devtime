class Summary::Build < ApplicationJob
  queue_as :default
  unique :until_executed, on_conflict: :log

  MAX_INTERVAL = 900 # 15 minutes
  def perform(account:)
    today_hits = account.hits.where("date(timestamp) = ?", Date.current).order(timestamp: :asc)
    sum = 0
    last_hit = nil
    today_hits.find_each.with_index do |hit, index|
      if index == 0
        last_hit = hit
        next
      end

      interval_between_hits = hit.timestamp - last_hit.timestamp
      sum += interval_between_hits if interval_between_hits < MAX_INTERVAL
      last_hit = hit
    end

    summary = Summary.find_or_initialize_by(account_id: account.id, day: Date.current)
    summary.total_time = sum
    summary.save
  end
end
