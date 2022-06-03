class Api::HitsController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :set_account

  def create
    Time.use_zone(@account.timezone) do
      @hit = Hit.new(hit_params)
      if @hit.valid?
        summary = Summary.find_or_create_by(account_id: @account.id, day: Time.zone.today)
        Summary.where(id: summary.id).update_all(["raw_hits = jsonb_insert(raw_hits, '{-1}', ?, true)", @hit.to_json])
        Summary::Build.perform_later(account: @account)
        head 201
      else
        head 422
      end
    end
  end

  def set_account
    @account = Account.find_by_api_token(request.headers["x-extension-api-token"])
    return if @account.is_a?(Account)

    head(:unauthorized)
  end

  def hit_params
    params.require(:hit).permit(:timestamp, :language, :project)
  end
end
