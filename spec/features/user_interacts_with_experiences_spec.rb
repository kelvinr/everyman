require 'rails_helper'

feature "User interacts with experiences" do
  scenario "User is not logged in" do
    visit experiences_path
    expect(page).not_to have_content 'Share your experiences'
  end

  scenario "User is logged in" do
    login(Fabricate(:user, username: "bob"))
    visit experiences_path

    click_link("Share your experiences as a Polyphasic sleeper!")
    expect(page).to have_content "New Experience"

    within("#new_experience") do
      fill_in "Title", with: "Just a test title that should be valid"
      fill_in "Body", with: "A small test paragraph that should pass, hopefully it all goes smoothly"
    end

    click_button "Publish"
    expect(page).to have_content "Your experience has been posted"
  end

  scenario "Edit link appears when current user has posted experiences" do
    login(Fabricate(:user, username: "bob"))
    Fabricate(:experience, user: User.first)

    visit experiences_path
    expect(find(".pull-right")).to have_content "Edit"
  end

  scenario "User updates expierence" do
    login(Fabricate(:user, username: "bob"))
    Fabricate(:experience, user: User.first, title: "temp title")

    visit experiences_path
    click_link "Edit"

    expect(page).to have_content "Edit Experience"

    within("#content-form") do
      fill_in "Title", with: "This is the modified title"
    end

    click_button "Update"
    expect(page).to have_content "This is the modified title"
  end
end
