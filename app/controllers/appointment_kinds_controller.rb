class AppointmentKindsController < ApplicationController
  def create
    appointment_kind = current_account.appointment_kinds.new(appointment_kind_params)

    if appointment_kind.save
      options_to_render = {
        partial: "appointments/appointment_kind_option",
        locals: {appointment_kind:}
      }
      render(turbo_stream: turbo_stream.append(:appointment_appointment_kind_id, **options_to_render))
    end
  end

  private

  def appointment_kind_params
    params.require(:appointment_kind).permit(:name)
  end
end
