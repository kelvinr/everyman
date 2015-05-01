require 'rails_helper'

describe SchedulesController do
  let(:bob) { Fabricate(:user) }

  before { set_current_user(bob) }

  describe "GET new" do
    it "sets @schedule" do
      get :new
      expect(assigns(:schedule)).to be_a_new(Schedule)
    end

    it_behaves_like "require login" do
      let(:action) { get :new }
    end
  end

  describe "POST create" do
    it "creates schedule with valid input" do
      post :create, schedule: Fabricate.attributes_for(:schedule)
      expect(Schedule.count).to eq(1)
    end

    it "redirects to user page on valid save" do
      post :create, schedule: Fabricate.attributes_for(:schedule)
      expect(response).to redirect_to bob
    end

    it "sets flash on successful save" do
      post :create, schedule: Fabricate.attributes_for(:schedule)
      expect(flash[:success]).not_to be_nil
    end

    it "renders the new template with invalid input" do
      post :create, schedule: Fabricate.attributes_for(:schedule, start_date: nil)
      expect(response).to render_template :new
    end

    it_behaves_like "require login" do
      let(:action) { post :create, schedule: Fabricate.attributes_for(:schedule) }
    end
  end

  describe "GET edit" do
    it "sets @schedule to current users schedule" do
      get :edit, id: Fabricate(:schedule, user: bob).id
      expect(assigns(:schedule)).to eq(bob.schedule)
    end

    it_behaves_like "require login" do
      let(:action) { get :edit, id: 2 }
    end
  end

  describe "POST update" do
    let(:schedule) { Fabricate(:schedule, user: bob) }

    it "updates schedule with valid input" do
      post :update, id: schedule.id, schedule: {nap_count: 7}
      expect(bob.reload.nap_count).to eq(7)
    end

    it "sets the flash message" do
      post :update, id: schedule.id, schedule: schedule.attributes
      expect(flash[:success]).not_to be_nil
    end

    it "redirects to the users page with valid input" do
      post :update, id: schedule.id, schedule: schedule.attributes
      expect(response).to redirect_to bob
    end

    it "renders edit when invalid input" do
      post :update, id: schedule.id, schedule: {start_date: nil}
      expect(response).to render_template :edit
    end

    it_behaves_like "require login" do
      let(:action) { post :update, id: 1, schedule: Fabricate.attributes_for(:schedule) }
    end
  end
end
