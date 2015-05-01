class User < ActiveRecord::Base
  validates :username, presence: true

  has_secure_password
  validates :password, length: { minimum: 5 }

  has_one :schedule
  has_many :experiences

  delegate :start_date, :end_date, :daily_sleep_goal, :core_sleep, :nap_count, :nap_duration, to: :schedule
end
