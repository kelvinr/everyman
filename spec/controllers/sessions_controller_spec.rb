require 'rails_helper'

describe SessionsController do

  describe "GET new" do
    it "sets @user" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe "POST create" do
    let(:bob) { Fabricate(:user) }

    context "with valid input" do
      before { post :create, username: bob.username, password: bob.password }

      it "redirects to user page" do
        expect(response).to redirect_to bob
      end

      it "stores user in session" do
        expect(session[:user_id]).not_to be_nil
      end

      it "sets flash success message" do
        expect(flash[:success]).not_to be_nil
      end
    end

    context "with invalid input" do
      before { post :create, username: bob.username, password: bob.password + "wrong" }
      it "renders the login page" do
        expect(response).to render_template :new
      end

      it "sets flash error message" do
        expect(flash[:danger]).not_to be_nil
      end
    end
  end

  describe "DELETE destroy" do
    before do
      set_current_user
      delete :destroy
    end

    it "redirects to the home page" do
      expect(response).to redirect_to :root
    end

    it "sets the session to nil" do
      expect(session[:user_id]).to be_nil
    end

    it "sets flash message" do
      expect(flash[:info]).not_to be_nil
    end
  end
end
