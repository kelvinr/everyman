require 'rails_helper'

describe Schedule do
  it { should belong_to(:user) }

  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:start_date) }
  it { should validate_presence_of(:daily_sleep_goal) }
  it { should validate_presence_of(:core_sleep) }
  it { should validate_presence_of(:nap_count) }
  it { should validate_presence_of(:nap_duration) }
end
