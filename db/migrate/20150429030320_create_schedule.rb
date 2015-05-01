class CreateSchedule < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.date :start_date
      t.date :end_date
      t.time :daily_sleep_goal
      t.time :core_sleep
      t.time :nap_duration
      t.integer :nap_count

      t.integer :user_id

      t.timestamps
    end
  end
end
