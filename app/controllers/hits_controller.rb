class HitsController < ApplicationController
  def index
    @hits = current_account.hits
  end
end
