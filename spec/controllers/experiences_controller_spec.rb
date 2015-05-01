require 'rails_helper'

describe ExperiencesController do
  let(:bob) { Fabricate(:user) }

  describe "GET index" do
    it "sets @experiences" do
      get :index
      expect(assigns(:experiences)).to eq(Experience.all)
    end
  end

  describe "GET new" do
    it "sets @experience" do
      set_current_user
      get :new
      expect(assigns(:experience)).to be_a_new(Experience)
    end

    it_behaves_like "require login" do
      let(:action) { get :new }
    end
  end

  describe "POST create" do
    before { set_current_user }

    it "creates experience with valid input" do
      post :create, experience: Fabricate.attributes_for(:experience)
      expect(Experience.count).to eq(1)
    end

    it "sets flash success message" do
      post :create, experience: Fabricate.attributes_for(:experience)
      expect(flash[:success]).not_to be_nil
    end

    it "redirects to experiences page on creation" do
      post :create, experience: Fabricate.attributes_for(:experience)
      expect(response).to redirect_to :experiences
    end

    it "renders the new template with invalid input" do
      post :create, experience: Fabricate.attributes_for(:experience, title: nil)
      expect(response).to render_template :new
    end

    it_behaves_like "require login" do
      let(:action) { post :create, experience: Fabricate.attributes_for(:experience) }
    end
  end

  describe "GET edit" do
    it "sets @experience" do
      set_current_user(bob)
      get :edit, id: Fabricate(:experience, user: bob)
      expect(assigns(:experience)).to eq(bob.experiences.first)
    end

    it_behaves_like "require login" do
      let(:action) { get :edit, id: 1}
    end
  end

  describe "POST update" do
    let(:exp) { Fabricate(:experience, user: bob) }

    before { set_current_user(bob) }

    it "redirects to the experience show page when valid input" do
      post :update, id: exp, experience: {title: "A new title."}
      expect(response).to redirect_to :experiences
    end

    it "updates the experience when valid input" do
      post :update, id: exp, experience: {title: "This is a valid title"}
      expect(exp.reload.title).to eq("This is a valid title")
    end

    it "sets flash message with valid input" do
      post :update, id: exp, experience: Fabricate.attributes_for(:experience)
      expect(flash[:success]).not_to be_nil
    end

    it "renders new template with invalid input" do
      post :update, id: exp, experience: Fabricate.attributes_for(:experience, title: nil)
    end

    it_behaves_like "require login" do
      let(:action) { post :update, id: exp, experience: Fabricate.attributes_for(:experience) }
    end
  end
end
