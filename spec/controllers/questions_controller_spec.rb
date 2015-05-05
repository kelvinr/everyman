require 'rails_helper'

describe QuestionsController do

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

    it "renders the new template on invalid input" do
      post :create, question: Fabricate.attributes_for(:question, question: nil)
      expect(response).to render_template :new
    end

    it_behaves_like "require login" do
      let(:action) { post :create, question: Fabricate.attributes_for(:question) }
    end
  end
end
