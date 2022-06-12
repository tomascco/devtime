class HitsController < ApplicationController
  def index
    @day = get_day
    @hits = Summary.where(account: current_account, day: @day)&.pluck(:raw_hits)&.first || []
  end

  private

  def get_day
    Date.parse(params[:day])
  rescue
    Time.zone.today
  end
end
