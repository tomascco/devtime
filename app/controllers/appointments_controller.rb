class AppointmentsController < ApplicationController
  def index
  end

  def new
    @appointment = current_account.appointments.new
  end
end
