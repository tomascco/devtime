class HitsController < ApplicationController
  def index
    @day = get_day
    @hits = current_account.summaries.where(day: @day)&.pluck(:raw_hits)&.first || []
    day_range = @day.beginning_of_day..@day.end_of_day

    appointment_attributes_values = current_account.appointments
      .joins(:appointment_kind)
      .where("? @> time_range", Appointment.connection.type_cast(day_range))
      .pluck("appointment_kinds.name", "lower(time_range)", "upper(time_range)")

    @appointments = appointment_attributes_values.map { APPOINTMENT_ATTRIBUTES.zip(_1).to_h }
  end

  private

  APPOINTMENT_ATTRIBUTES = [:name, :start_time, :end_time]

  def get_day
    Date.parse(params[:day])
  rescue
    Time.zone.today
  end
end
