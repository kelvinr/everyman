Fabricator(:schedule) do
  user { Fabricate(:user) }
  start_date { Time.new }
  daily_sleep_goal { Time.new }
  core_sleep { Time.new }
  nap_count { (1..6).to_a.sample }
  nap_duration { Time.new }
end
