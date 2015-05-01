class Schedule < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :user, :start_date, :daily_sleep_goal, :core_sleep, :nap_count, :nap_duration
end
