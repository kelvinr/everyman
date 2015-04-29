require 'rails_helper'

feature 'User login' do
  scenario "with valid info" do
    bob = Fabricate(:user)
    visit login_path
    within("#user-form") do
      fill_in "Username / Email", with: bob.username
      fill_in "Password", with: bob.password
    end

    click_button 'Login'
    expect(page).to have_content bob.username
  end

  scenario "with invalid info" do
    alice = Fabricate(:user)
    visit login_path
    within("#user-form") do
      fill_in "Username / Email", with: alice.username
      fill_in "Password", with: alice.password + "jkaflda"
    end

    click_button 'Login'
    expect(page).to have_content "Incorrect username or password."
  end
end
