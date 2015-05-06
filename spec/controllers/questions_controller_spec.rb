require 'rails_helper'

describe QuestionsController do
  let(:bob) { Fabricate(:user) }

  describe "GET index" do
    it "sets @questions in desc order" do
      que1 = Fabricate(:question, created_at: 2.days.ago)
      que2 = Fabricate(:question)
      get :index
      expect(assigns(:questions)).to eq([que2,que1])
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
      it "redirects to questions page on creation" do
        post :create, question: Fabricate.attributes_for(:question)
        expect(response).to redirect_to :questions
      end

      it "creates question with valid input" do
        post :create, question: Fabricate.attributes_for(:question)
        expect(Question.count).to eq(1)
      end

      it "sets the flash message" do
        post :create, question: Fabricate.attributes_for(:question)
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
      question = Fabricate(:question, user: bob)
      get :edit, id: question.id
      expect(assigns(:question)).to eq(question)
    end

    it_behaves_like "require login" do
      let(:action) { get :edit, id: 1 }
    end
  end

  describe "POST update" do
    before { set_current_user(bob) }
    let(:question) { Fabricate(:question, user: bob) }

    context "with valid input" do
      it "redirects to the questions page" do
        post :update, id: question.id, question: {additional_info: "Can you answer this question?"}
        expect(response).to redirect_to :questions
      end

      it "sets flash message" do
        post :update, id: question.id, question: {question: "Is a valid question?"}
        expect(flash[:success]).not_to be_nil
      end

      it "updates the question" do
        post :update, id: question.id, question: {question: "Is this a valid question?"}
        expect(question.reload.question).to eq("Is this a valid question?")
      end
    end

    context "with invalid input or unathenticated user" do

      it "renders the edit template" do
        post :update, id: question.id, question: {question: nil}
        expect(response).to render_template :edit
      end

      it_behaves_like "require login" do
        let(:action) { post :update, id: question.id }
      end
    end
  end
end
