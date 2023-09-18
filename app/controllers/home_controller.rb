class HomeController < ApplicationController
  def index
    today_programming_total_time =
      Summary.where(account: current_account, day: Time.current).pick(:total_time).to_i
    yesterday_programming_total_time =
      Summary.where(account: current_account, day: Time.zone.yesterday).pick(:total_time).to_i

    today_appointments_total_time = Appointment
      .where("? @> time_range", Appointment.connection.type_cast(Time.current.beginning_of_day..Time.current.end_of_day))
      .reduce(0) { _1 + _2.duration.to_i }

    yesterday_appointments_total_time = Appointment
      .where("? @> time_range", Appointment.connection.type_cast(Time.zone.yesterday.beginning_of_day..Time.zone.yesterday.end_of_day))
      .reduce(0) { _1 + _2.duration.to_i }

    @today_summary = today_programming_total_time + today_appointments_total_time
    @yesterday_summary = yesterday_programming_total_time + yesterday_appointments_total_time

    programming_summaries = Summary
      .where(account: current_account, day: date_range)
      .order(:day)
      .pluck(:day, :total_time, :projects, :languages)
    @languages_hash = Language.all_in_hash

    appointments = Appointment.includes(:appointment_kind).where("? @> time_range", Appointment.connection.type_cast(date_range))
    appointment_summaries = appointments.group_by { _1.time_range.begin.to_date }.map do |(day, appointments)|
      total_duration = appointments.reduce(0) { _1 + _2.duration.to_i }

      duration_by_appointment = appointments.each_with_object(Hash.new(0.0)) do |appointment, hash|
        hash[appointment.appointment_kind.name] += appointment.duration
      end

      [day, total_duration, duration_by_appointment, {"appointment" => total_duration}]
    end

    @range_summaries = date_range.each_with_object([]) do |day, array|
      programming_summary = programming_summaries.find { day == _1.first }
      appointment_summary = appointment_summaries.find { day == _1.first }

      if programming_summary.present? && appointment_summary.blank?
        array << programming_summary and next
      elsif programming_summary.blank? && appointment_summary.present?
        array << appointment_summary and next
      elsif programming_summary.blank? && appointment_summary.blank?
        array << [day, 0, {}, {}] and next
      end

      array << [
        day,
        programming_summary[1] + appointment_summary[1],
        {**programming_summary[2], **appointment_summary[2]},
        {**programming_summary[3], **appointment_summary[3]}
      ]
    end
  end

  private

  def date_range
    if params[:range] && ApplicationHelper::TIME_RANGES[params[:range]]
      session[:default_range] = params[:range]
    end
    session[:default_range] ||= "last_seven_days"
    ApplicationHelper::TIME_RANGES[session[:default_range]].call
  end
end
