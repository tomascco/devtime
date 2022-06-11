module ApplicationHelper
  TIME_RANGES = {
    "last_seven_days" => -> { 6.days.ago..Time.zone.today },
    "this_week" => -> { Time.zone.today.beginning_of_week..Time.zone.today },
    "past_week" => -> { Time.zone.today.last_week..Time.zone.today.last_week.end_of_week },
    "last_two_weeks" => -> { Time.zone.today.last_week..Time.zone.today },
    "this_month" => -> { Time.zone.today.beginning_of_month..Time.zone.today },
    "past_month" => -> { Time.zone.today.last_month.beginning_of_month..Time.zone.today.last_month.end_of_month }
  }
end
