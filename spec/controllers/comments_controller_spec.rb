require 'rails_helper'

describe CommentsController do
  let(:bob) { Fabricate(:user) }
  let(:exp) { Fabricate(:experience) }
  let(:que) { Fabricate(:question) }

  describe "POST create" do
    before { set_current_user }
    let(:comment) { que.comments.new(content: "Test comment") }

    context "with valid input" do
      before { post :create, question_id: que, comment: comment.attributes }

      it "redirects to commentable page" do
        expect(response).to redirect_to que
      end

      it "creates comment with valid info" do
        expect(que.comments.count).to eq(1)
      end

      it "sets the flash message" do
        expect(flash[:success]).not_to be_nil
      end
    end

    context "with invalid input or unauthenticated user" do
      it "renders the commentable show page with invalid input" do
        post :create, question_id: que, comment: {content: nil}
        expect(response).to render_template "questions/show"
      end
    end

    it_behaves_like "require login" do
      let(:action) { post :create, question_id: que, comment: comment.attributes }
    end
  end

  describe "GET edit" do
    let(:comment) { que.comments.create(content: "Test comment", user: bob) }

    it "sets @comment" do
      set_current_user(bob)
      get :edit, question_id: que, id: comment
      expect(assigns(:comment)).to eq(comment)
    end

    it_behaves_like "require login" do
      let(:action) { get :edit, question_id: que, id: comment }
    end

    it_behaves_like "require correct user" do
      let(:action) { get :edit, question_id: que, id: comment }
    end
  end

  describe "PATCH update" do
    before { set_current_user(bob) }
    let(:comment) { exp.comments.create(content: "Test comment", user: bob) }

    it "redirects to the commentable show page" do
      patch :update, experience_id: exp, id: comment, comment: comment.attributes
      expect(response).to redirect_to exp
    end

    it "sets the flash message" do
      patch :update, experience_id: exp, id: comment, comment: comment.attributes
      expect(flash[:success]).not_to be_nil
    end

    it "updates the comment" do
      patch :update, experience_id: exp, id: comment, comment: {content: "This should be the new comment."}
      expect(comment.reload.content).to eq("This should be the new comment.")
    end

    it "renders the new template with invalid input" do
      patch :update, experience_id: exp, id: comment, comment: {content: nil}
      expect(response).to render_template :edit
    end

    it_behaves_like "require login" do
      let(:action) { patch :update, experience_id: exp, id: 2 }
    end

    it_behaves_like "require correct user" do
      let(:action) { patch :update, experience_id: exp, id: 1}
    end
  end
end
