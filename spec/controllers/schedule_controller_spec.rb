require 'rails_helper'

describe SchedulesController do
  let(:bob) { Fabricate(:user) }
  describe "GET new" do
    it "sets @schedule" do
      set_current_user
      get :new
      expect(assigns(:schedule)).to be_a_new(Schedule)
    end

    it_behaves_like "require login" do
      let(:action) { get :new }
    end
  end

  describe "POST create" do
    it "creates schedule with valid input" do
      set_current_user(bob)
      post :create, schedule: Fabricate.attributes_for(:schedule)
      expect(Schedule.count).to eq(1)
    end

    it "redirects to user page on valid save" do
      set_current_user(bob)
      post :create, schedule: Fabricate.attributes_for(:schedule)
      expect(response).to redirect_to bob
    end

    it "sets flash on successful save" do
      set_current_user(bob)
      post :create, schedule: Fabricate.attributes_for(:schedule)
      expect(flash[:success]).not_to be_nil
    end

    it "renders the new template with invalid input" do
      set_current_user(bob)
      post :create, schedule: Fabricate.attributes_for(:schedule, start_date: nil)
      expect(response).to render_template :new
    end

    it_behaves_like "require login" do
      let(:action) { post :create, schedule: Fabricate.attributes_for(:schedule) }
    end
  end

  describe "GET edit" do
    it "sets @schedule to current users schedule" do
      set_current_user(bob)
      get :edit, id: Fabricate(:schedule, user: bob).id
      expect(assigns(:schedule)).to eq(bob.schedule)
    end

    it_behaves_like "require login" do
      let(:action) { get :edit, id: 2 }
    end
  end

  describe "POST update" do
    it "updates schedule with valid input" do
      set_current_user(bob)
      schedule = Fabricate(:schedule, user: bob, nap_count: 3)
      post :update, id: schedule.id, schedule: {nap_count: 4}
      expect(bob.reload.nap_count).to eq(4)
    end

    it "sets the flash message" do
      set_current_user(bob)
      schedule = Fabricate(:schedule, user: bob)
      post :update, id: schedule.id, schedule: schedule.attributes
      expect(flash[:success]).not_to be_nil
    end

    it "redirects to the users page with valid input" do
      set_current_user(bob)
      schedule = Fabricate(:schedule, user: bob)
      post :update, id: schedule.id, schedule: schedule.attributes
      expect(response).to redirect_to bob
    end

    it "renders edit when invalid input" do
      set_current_user(bob)
      schedule = Fabricate(:schedule, user: bob)
      post :update, id: schedule.id, schedule: {start_date: nil}
      expect(response).to render_template :edit
    end

    it_behaves_like "require login" do
      let(:action) { post :update, id: 1, schedule: Fabricate.attributes_for(:schedule) }
    end
  end
end
