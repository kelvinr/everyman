require 'rails_helper'

describe Question do
  it { should belong_to(:user) }
  it { should have_many(:comments) }

  it { should validate_presence_of(:question) }
  it { should validate_presence_of(:user) }

  it_behaves_like "orders comments by creation" do
    let(:object) { Fabricate(:question) }
  end
end
