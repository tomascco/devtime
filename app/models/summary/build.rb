class Summary::Build < ApplicationJob
  queue_as :default
  unique :until_executed, on_conflict: :log

  MAX_INTERVAL = 900 # 15 minutes
  def perform(account:, day: Date.current)
    today_hits = account.hits.where("date(timestamp) = ?", day).order(timestamp: :asc)
    sum = 1
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

    summary = Summary.find_or_initialize_by(account_id: account.id, day: day)
    summary.total_time = (summary.total_time || 0) + sum
    processed_hits = today_hits.map do |hit|
      attributes = hit.attributes.except(*%w[created_at updated_at account_id id])
      attributes[:version] = 1
      attributes
    end
    if summary.raw_hits
      summary.raw_hits.concat(processed_hits)
    else
      summary.raw_hits = processed_hits
    end
    summary.save
    today_hits.delete_all
  end
end
