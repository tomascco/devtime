class ApplicationController < ActionController::Base
  around_action :set_time_zone

  def set_time_zone
    Time.use_zone(rodauth.logged_in? ? current_account.timezone : "UTC") { yield }
  end
end
