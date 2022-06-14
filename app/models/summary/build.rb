class Summary::Build < ApplicationJob
  queue_as :default
  unique :until_executed, on_conflict: :log

  MAX_INTERVAL = 900 # 15 minutes
  def perform(account:, day: Time.zone.today)
    summary = Summary.find_by(account_id: account.id, day: day)
    return if summary.nil?

    sum = 0
    last_hit_time = nil
    last_language = nil
    last_project = nil
    languages = {}
    projects = {}
    summary.raw_hits.each do |raw_hit|
      hit = Hit.new(raw_hit)
      if last_hit_time.nil?
        last_hit_time = hit.timestamp
        last_project = hit.project
        last_language = hit.language
        next
      end

      interval_between_hits = hit.timestamp - last_hit_time
      if interval_between_hits < MAX_INTERVAL
        sum += interval_between_hits
        languages[last_language] = (languages[last_language] || 0) + interval_between_hits
        projects[last_project] = (projects[last_project] || 0) + interval_between_hits
      end
      last_hit_time = hit.timestamp
      last_project = hit.project
      last_language = hit.language
    end

    summary.projects = projects
    summary.languages = languages
    summary.total_time = sum
    summary.save
  end
end
