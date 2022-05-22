class HitsController < ApplicationController
  include Pagy::Backend

  def index
    @pagy, @hits = pagy(current_account.hits.order(created_at: :desc))
  end
end
