class HomeController < ApplicationController
  def index
    @today_summary = Summary.find_by(account: current_account, day: Time.zone.today)
    @yesterday_summary = Summary.find_by(account: current_account, day: Time.zone.yesterday)
    @week_summaries = Summary.where(account: current_account, day: 6.days.ago..Time.zone.today).pluck(:day, :total_time)
  end
end
