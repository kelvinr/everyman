require 'rails_helper'

describe User do
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:password) }
  it { should validate_length_of(:password).is_at_least(5) }

  it { should have_one(:schedule) }
  it { should have_many(:experiences) }
  it { should have_many(:questions) }

  it { should delegate_method(:start_date).to(:schedule) }
  it { should delegate_method(:end_date).to(:schedule) }
  it { should delegate_method(:daily_sleep_goal).to(:schedule) }
  it { should delegate_method(:core_sleep).to(:schedule) }
  it { should delegate_method(:nap_count).to(:schedule) }
  it { should delegate_method(:nap_duration).to(:schedule) }
end
