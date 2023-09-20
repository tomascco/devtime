class AppointmentsController < ApplicationController
  def index
    @appointments = current_account.appointments.includes(:appointment_kind)
  end

  def new
    @appointment = current_account.appointments.new
  end

  def create
    appointment = current_account.appointments.new(appointment_params)

    appointment.time_range = appointment.time_range_start..appointment.time_range_end

    if appointment.save
      redirect_to(appointments_path)
    end
  end

  def edit
    @appointment = current_account.appointments.find(params[:id])

    @appointment.time_range_start = @appointment.time_range.begin
    @appointment.time_range_end = @appointment.time_range.end
  end

  def update
    appointment = current_account.appointments.find(params[:id])

    appointment.assign_attributes(appointment_params)

    appointment.time_range = appointment.time_range_start..appointment.time_range_end

    if appointment.save
      redirect_to(appointments_path)
    end
  end

  def destroy
    appointment = current_account.appointments.find(params[:id])

    if appointment.destroy
      redirect_to(appointments_path)
    end
  end

  private

  def appointment_params
    params.require(:appointment).permit(:time_range_start, :time_range_end, :comment, :appointment_kind_id)
  end
end
