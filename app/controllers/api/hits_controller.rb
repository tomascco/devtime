class Api::HitsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @hit = Hit.new(hit_params)
    @hit.account = current_account

    respond_to do |format|
      if @hit.save
        format.json { render json: @hit.to_json, status: :created }
      else
        format.json { render json: @hit.errors, status: :unprocessable_entity }
      end
    end
  end

  def hit_params
    params.require(:hit).permit(:timestamp, :language, :project)
  end
end
