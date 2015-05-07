require 'rails_helper'

describe UsersController do
  describe "GET show" do
    it "sets @user" do
      user = Fabricate(:user)
      get :show, id: user.id
      expect(assigns(:user)).to eq(User.find(user.id))
    end
  end

  describe "GET new" do
    it "sets @user" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe "POST create" do
    context "with valid input" do
      it "creates the user" do
        post :create, user: Fabricate.attributes_for(:user)
        expect(User.count).to eq(1)
      end

      it "set flash message" do
        post :create, user: Fabricate.attributes_for(:user)
        expect(flash[:success]).not_to be_nil
      end

      it "redirects to the home page after user creation" do
        post :create, user: Fabricate.attributes_for(:user)
        expect(response).to redirect_to User.first
      end
    end

    context "with invalid input" do
      it "renders the new template" do
        post :create, user: Fabricate.attributes_for(:user, password: '')
        expect(response).to render_template :new
      end
    end
  end
end
