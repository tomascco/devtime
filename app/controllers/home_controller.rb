class HomeController < ApplicationController
  def index
    @today_summary = Summary.find_by(account: current_account, day: Time.zone.today) || Summary.empty
    @yesterday_summary = Summary.find_by(account: current_account, day: Time.zone.yesterday) || Summary.empty
    @range_summaries = Summary.where(account: current_account, day: date_range).order(:day).pluck(:day, :total_time, :projects, :languages)
    @languages_hash = Language.all_in_hash
  end

  private

  def date_range
    if params[:range] && ApplicationHelper::TIME_RANGES[params[:range]]
      session[:default_range] = params[:range]
    end
    session[:default_range] ||= "last_seven_days"
    ApplicationHelper::TIME_RANGES[session[:default_range]].call
  end
end
