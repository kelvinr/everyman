Fabricator(:schedule) do
  start_date { Time.now.strftime("%Y-%m-%d") }
  daily_sleep_goal { Time.new }
  core_sleep { Time.new }
  nap_count { (1..6).to_a.sample }
  nap_duration { Time.new }
end
