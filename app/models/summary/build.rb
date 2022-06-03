class Summary::Build < ApplicationJob
  queue_as :default
  unique :until_executed, on_conflict: :log

  MAX_INTERVAL = 900 # 15 minutes
  def perform(account:, day: Time.zone.today)
    summary = Summary.find_by(account_id: account.id, day: day)
    return if summary.nil?

    sum = 0
    last_hit_time = nil
    summary.raw_hits.each do |raw_hit|
      hit = Hit.new(raw_hit.symbolize_keys)
      if last_hit_time.nil?
        last_hit_time = hit.timestamp
        next
      end

      interval_between_hits = hit.timestamp - last_hit_time
      sum += interval_between_hits if interval_between_hits < MAX_INTERVAL
      last_hit_time = hit.timestamp
    end

    summary.total_time = sum
    summary.save
  end
end
