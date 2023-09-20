module ApplicationHelper
  TIME_RANGES = {
    "last_seven_days" => -> { 6.days.ago.to_date..Time.current },
    "this_week" => -> { Time.zone.today.beginning_of_week..Time.current },
    "past_week" => -> { Time.zone.today.last_week..Time.current.last_week.end_of_week },
    "last_two_weeks" => -> { Time.zone.today.last_week..Time.current },
    "this_month" => -> { Time.zone.today.beginning_of_month..Time.current },
    "past_month" => -> { Time.zone.today.last_month.beginning_of_month..Time.current.last_month.end_of_month }
  }
end
