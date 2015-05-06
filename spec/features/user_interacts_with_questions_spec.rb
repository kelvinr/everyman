require 'rails_helper'

feature "User interacts with questions" do

  scenario "User is not logged in" do
    visit questions_path
    expect(page).not_to have_content "Ask a question"
  end

  scenario "User is logged in" do
    login
    visit questions_path

    click_link "Ask a question"
    expect(page).to have_content "New Question"

    within("#new_question") do
      fill_in "Question", with: "How long have you been a polymorphic sleeper?"
      fill_in "Additional info", with: "When was the first time you attempted polymorphic sleep?"
    end

    click_button "Create"
    expect(page).to have_content "Your question has been submitted."
  end

  scenario "Edit link present when user has a posted question" do
    login(Fabricate(:user, username: "bob"))
    Fabricate(:question, user: User.first)

    visit questions_path
    expect(find(".pull-right")).to have_content "Edit"
  end

  scenario "User updates question" do
    login(Fabricate(:user, username: "bob"))
    Fabricate(:question, user: User.first, question: "temp question")

    visit questions_path
    click_link "Edit"

    expect(page).to have_content "Edit Question"

    within("#content-form") do
      fill_in "Question", with: "Did the question change?"
      fill_in "Additional info", with: ""
    end

    click_button "Update"
    expect(page).to have_content "Did the question change?"
  end
end
