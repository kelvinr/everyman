require 'rails_helper'

feature "User interacts with polymorphic comments" do
  given(:exp) { Fabricate(:experience) }
  given(:que) { Fabricate(:question) }
  given(:bob) { Fabricate(:user) }

  context "User is not logged in" do
    scenario "Comment form is not present" do
      visit experience_path(exp)
      expect(page).not_to have_content "New Comment"

      visit question_path(que)
      expect(page).not_to have_content "New Comment"
    end
  end

  context "User is logged in" do
    background { login(bob) }

    scenario "Comment form present" do
      visit experience_path(exp)
      expect(page).to have_content "New Comment"

      visit question_path(que)
      expect(page).to have_content "New Comment"
    end

    context "User interacts with Experience comments" do
      scenario "User creates comment with valid input" do
        visit experience_path(exp)

        within("#new_comment") do
          fill_in "comment_content", with: "This is a comment on an experience."
        end

        click_button "Create"
        expect(page).to have_content "This is a comment on an experience."
      end

      scenario "User creates comment with invalid input" do
        visit experience_path(exp)

        click_button "Create"
        expect(page).to have_content "The Form contains 1 error"
      end

      scenario "Edit link only visible to comment creator" do
        exp.comments.create(content: "Test comment", user: bob)
        visit experience_path(exp)

        expect(find(".pull-right")).to have_content "Edit"

        login
        visit experience_path(exp)
        expect(page).not_to have_selector "small.pull-right"
      end

      scenario "User Edits comment" do
        exp.comments.create(content: "Placeholder", user: bob)
        visit experience_path(exp)

        click_link "Edit"

        expect(page).to have_content "Edit Comment"

        within("#content-form") do
          fill_in "comment_content", with: "This is my new comment!"
        end

        click_button "Update"
        expect(page).to have_content "This is my new comment!"
      end
    end

    context "User interacts with Question comments" do
      scenario "User comments on a question with valid info" do
        visit question_path(que)

        within("#new_comment") do
          fill_in "comment_content", with: "This is a question comment."
        end

        click_button "Create"
        expect(page).to have_content "This is a question comment."
      end

      scenario "User creates comment with invalid info" do
        visit question_path(que)

        click_button "Create"
        expect(page).to have_content "The Form contains 1 error"
      end

      scenario "Edit link is only visible to comment creator" do
        que.comments.create(content: "Test comment", user: bob)
        visit question_path(que)

        expect(find("small.pull-right")).to have_content "Edit"

        login
        visit question_path(que)
        expect(page).not_to have_selector "small.pull-right"
      end

      scenario "User Edits comment" do
        que.comments.create(content: "Placeholder", user: bob)
        visit question_path(que)

        click_link "Edit"

        expect(page).to have_content "Edit Comment"

        within("#content-form") do
          fill_in "comment_content", with: "This is my new comment!"
        end

        click_button "Update"
        expect(page).to have_content "This is my new comment!"
      end
    end
  end
end
