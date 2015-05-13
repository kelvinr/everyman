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
    context "with valid input" do
      before { post :create, schedule: Fabricate.attributes_for(:schedule, user: bob) }

      it "creates schedule with valid input" do
        expect(Schedule.count).to eq(1)
      end

      it "redirects to user page on valid save" do
        expect(response).to redirect_to bob
      end

      it "sets flash on successful save" do
        expect(flash[:success]).not_to be_nil
      end
    end

    context "with invalid input or user" do
      it "renders the new template" do
        post :create, schedule: Fabricate.attributes_for(:schedule, start_date: nil, user: bob)
        expect(response).to render_template :new
      end

      it_behaves_like "require login" do
        let(:action) { post :create, schedule: Fabricate.attributes_for(:schedule, user: bob) }
      end
    end
  end

  describe "GET edit" do
    let(:schedule) { Fabricate(:schedule, user: bob)}

    it "sets @schedule to current users schedule" do
      get :edit, id: schedule.id
      expect(assigns(:schedule)).to eq(bob.schedule)
    end

    it_behaves_like "require login" do
      let(:action) { get :edit, id: schedule.id }
    end

    it_behaves_like "require correct user" do
      let(:action) { get :edit, id: schedule.id }
    end
  end

  describe "PATCH update" do
    let(:schedule) { Fabricate(:schedule, user: bob) }

    it "updates schedule with valid input" do
      patch :update, id: schedule, schedule: {nap_count: 7}
      expect(bob.reload.nap_count).to eq(7)
    end

    it "sets the flash message" do
      patch :update, id: schedule, schedule: Fabricate.attributes_for(:schedule)
      expect(flash[:success]).not_to be_nil
    end

    it "redirects to the users page with valid input" do
      patch :update, id: schedule, schedule: Fabricate.attributes_for(:schedule)
      expect(response).to redirect_to bob
    end

    it "renders edit when invalid input" do
      patch :update, id: schedule.id, schedule: {start_date: nil}
      expect(response).to render_template :edit
    end

    it_behaves_like "require login" do
      let(:action) { patch :update, id: schedule.id, schedule: schedule.attributes }
    end

    it_behaves_like "require correct user" do
      let(:action) { patch :update, id: schedule.id, schedule: schedule.attributes }
    end
  end
end
