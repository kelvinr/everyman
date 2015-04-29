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

      it "redirects to user page" do
        post :create, username: bob.username, password: bob.password
        expect(response).to redirect_to bob
      end

      it "stores user in session" do
        post :create, username: bob.username, password: bob.password
        expect(session[:user_id]).not_to be_nil
      end

      it "sets flash success message" do
        post :create, username: bob.username, password: bob.password
        expect(flash[:success]).not_to be_nil
      end
    end

    context "with invalid input" do
      it "renders the login page" do
        post :create, username: bob.username, password: bob.password + "dakfj"
        expect(response).to render_template :new
      end

      it "sets flash error message" do
        post :create, username: bob.username, password: bob.password + "kdjfakl"
        expect(flash[:danger]).not_to be_nil
      end
    end
  end

  describe "DELETE destroy" do
    before { session[:user_id] = Fabricate(:user).id }

    it "redirects to the home page" do
      delete :destroy
      expect(response).to redirect_to :root
    end

    it "sets the session to nil" do
      delete :destroy
      expect(session[:user_id]).to be_nil
    end

    it "sets flash message" do
      delete :destroy
      expect(flash[:info]).not_to be_nil
    end
  end
end
