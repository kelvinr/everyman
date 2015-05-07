require 'rails_helper'

feature "User interacts with schedule" do

  scenario "User creates schedule with valid info" do
    login
    visit new_schedule_path

    within("#new_schedule") do
      fill_in "Start date", with: Time.new.strftime("%Y-%m-%d")
      fill_in "End date", with: Time.new.strftime("%Y-%m-%d")
      fill_in "Daily total", with: Time.new
      fill_in "Core sleep", with: Time.new
      fill_in "Total Naps", with: 4
      fill_in "Nap duration", with: Time.new
    end

    click_button "Save"
    expect(page).to have_content "Your schedule has been created."
  end

  scenario "User enters invalid infomation" do
    login
    visit new_schedule_path

    within("#new_schedule") do
      fill_in "Start date", with: Time.new.strftime("%Y-%m-%d")
      fill_in "End date", with: Time.new.strftime("%Y-%m-%d")
      fill_in "Daily total", with: Time.new
      fill_in "Core sleep", with: Time.new
      fill_in "Total Naps", with: nil
      fill_in "Nap duration", with: nil
    end

    click_button "Save"
    expect(page).to have_content "The Form contains 2 errors"
  end

  scenario "User edits their schedule" do
    bob = Fabricate(:user)
    login(bob)
    Fabricate(:schedule, user: bob, nap_count: 3)
    visit edit_schedule_path(bob.schedule)

    within("#edit_schedule_#{bob.schedule.id}") do
      fill_in "Start date", with: Time.new.strftime("%Y-%m-%d")
      fill_in "Daily total", with: Time.new
      fill_in "Core sleep", with: Time.new
      fill_in "Total Naps", with: 4
      fill_in "Nap duration", with: Time.new
    end

    click_button "Save"
    expect(page).to have_content "Your schedule has been updated."
  end
end
