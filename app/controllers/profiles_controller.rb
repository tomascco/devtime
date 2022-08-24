class ProfilesController < ApplicationController
  def show
    @account = current_account
  end

  def update
    timezone = ActiveSupport::TimeZone[timezone_param]
    if timezone
      current_account.update(timezone: timezone.name)
    end

    redirect_to profile_path
  end

  private

  def timezone_param
    params.require(:account).permit(:timezone)[:timezone]
  end
end
