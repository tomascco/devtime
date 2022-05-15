class Api::HitsController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :set_account

  def create
    @hit = Hit.new(hit_params)
    @hit.account = @account

    respond_to do |format|
      if @hit.save
        format.json { render json: @hit.to_json, status: :created }
      else
        format.json { render json: @hit.errors, status: :unprocessable_entity }
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
