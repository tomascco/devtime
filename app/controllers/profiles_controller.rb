class ProfilesController < ApplicationController
  def show
    @account = current_account
    @host = request.host_with_port
  end
end
