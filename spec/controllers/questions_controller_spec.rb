require 'rails_helper'

describe QuestionsController do
  let(:bob) { Fabricate(:user) }
  let(:question) { Fabricate(:question, user: bob) }

  describe "GET index" do
    it "sets @questions in desc order" do
      que1 = Fabricate(:question, created_at: 2.days.ago)
      que2 = Fabricate(:question)
      get :index
      expect(assigns(:questions)).to eq([que2,que1])
    end
  end

  describe "GET show" do
    before { get :show, id: question }

    it "sets @question" do
      expect(assigns(:question)).to eq(question)
    end

    it "sets @comment" do
      expect(assigns(:comment)).to be_a_new(Comment)
    end
  end

  describe "GET new" do
    it "sets @question" do
      set_current_user
      get :new
      expect(assigns(:question)).to be_a_new(Question)
    end

    it_behaves_like "require login" do
      let(:action) { get :new }
    end
  end

  describe "POST create" do
    before { set_current_user }

    context "with valid input" do
      before { post :create, question: Fabricate.attributes_for(:question) }

      it "redirects to questions page on creation" do
        expect(response).to redirect_to :questions
      end

      it "creates question with valid input" do
        expect(Question.count).to eq(1)
      end

      it "sets the flash message" do
        expect(flash[:success]).not_to be_nil
      end
    end

    context "with invalid input or unauthenticated user" do
      it "renders the new template on invalid input" do
        post :create, question: Fabricate.attributes_for(:question, question: nil)
        expect(response).to render_template :new
      end

      it_behaves_like "require login" do
        let(:action) { post :create, question: Fabricate.attributes_for(:question) }
      end
    end
  end

  describe "GET edit" do
    it "sets @question" do
      set_current_user(bob)
      get :edit, id: question
      expect(assigns(:question)).to eq(question)
    end

    it_behaves_like "require login" do
      let(:action) { get :edit, id: question }
    end

    it_behaves_like "require correct user" do
      let(:action) { get :edit, id: question }
    end
  end

  describe "PATCH update" do
    before { set_current_user(bob) }

    context "with valid input" do
      before { patch :update, id: question, question: {question: "Is this a valid question?"} }

      it "redirects to the questions page" do
        expect(response).to redirect_to :questions
      end

      it "sets flash message" do
        expect(flash[:success]).not_to be_nil
      end

      it "updates the question" do
        expect(question.reload.question).to eq("Is this a valid question?")
      end
    end

    context "with invalid input or user" do
      it "renders the edit template" do
        patch :update, id: question, question: {question: nil}
        expect(response).to render_template :edit
      end

      it_behaves_like "require login" do
        let(:action) { patch :update, id: question }
      end

      it_behaves_like "require correct user" do
        let(:action) { patch :update, id: question}
      end
    end
  end
end
