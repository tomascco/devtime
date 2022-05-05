class HitsController < ApplicationController
  before_action :set_hit, only: %i[ show edit update destroy ]

  # GET /hits or /hits.json
  def index
    @hits = current_account.hits
  end
end
