class HitsController < ApplicationController
  def index
    @hits = Summary.where(account: current_account, day: Time.zone.today).pluck(:raw_hits).first
  end
end
