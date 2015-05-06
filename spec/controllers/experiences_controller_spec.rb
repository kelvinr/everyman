require 'rails_helper'

describe ExperiencesController do
  let(:bob) { Fabricate(:user) }
  let(:exp) { Fabricate(:experience, user: bob) }

  describe "GET index" do
    it "sets @experiences" do
      get :index
      expect(assigns(:experiences)).to eq(Experience.all)
    end
  end

  describe "Get show" do
    before { get :show, id: exp.id }

    it "sets @experience" do
      expect(assigns(:experience)).to eq(exp)
    end

    it "sets @comment" do
      expect(assigns(:comment)).to be_a_new(Comment)
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

    context "with valid input" do
      before { post :create, experience: Fabricate.attributes_for(:experience) }

      it "creates experience" do
        expect(Experience.count).to eq(1)
      end

      it "sets flash message" do
        expect(flash[:success]).not_to be_nil
      end

      it "redirects to experience show page" do
        expect(response).to redirect_to Experience.first
      end
    end

    context "with invalid input or unauthenticated user" do
      it "renders the new template" do
        post :create, experience: Fabricate.attributes_for(:experience, title: nil)
        expect(response).to render_template :new
      end

      it_behaves_like "require login" do
        let(:action) { post :create, experience: Fabricate.attributes_for(:experience) }
      end
    end
  end

  describe "GET edit" do
    it "sets @experience" do
      set_current_user(bob)
      get :edit, id: exp
      expect(assigns(:experience)).to eq(bob.experiences.first)
    end

    it_behaves_like "require login" do
      let(:action) { get :edit, id: exp }
    end

    it_behaves_like "require correct user" do
      let(:action) { get :edit, id: exp }
    end
  end

  describe "PATCH update" do
    before { set_current_user(bob) }

    it "redirects to the experience show page when valid input" do
      patch :update, id: exp, experience: {title: "A new title."}
      expect(response).to redirect_to exp
    end

    it "updates the experience when valid input" do
      patch :update, id: exp, experience: {title: "This is a valid title"}
      expect(exp.reload.title).to eq("This is a valid title")
    end

    it "sets flash message with valid input" do
      patch :update, id: exp, experience: exp.attributes
      expect(flash[:success]).not_to be_nil
    end

    it "renders new template with invalid input" do
      patch :update, id: exp, experience: Fabricate.attributes_for(:experience, title: nil)
    end

    it_behaves_like "require login" do
      let(:action) { patch :update, id: exp, experience: exp.attributes }
    end

    it_behaves_like "require correct user" do
      let(:action) { patch :update, id: exp, experience: exp.attributes }
    end
  end
end
