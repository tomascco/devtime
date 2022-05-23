class HomeController < ApplicationController
  def index
    @today_summary = Summary.find_by(account: current_account, day: Time.zone.today)
    @yesterday_summary = Summary.find_by(account: current_account, day: Time.zone.yesterday)
  end
end
