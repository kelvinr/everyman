require 'rails_helper'

describe Experience do
  it { should belong_to(:user) }
  it { should have_many(:comments) }

  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:body) }

  it_behaves_like "orders comments by creation" do
    let(:object) { Fabricate(:experience) }
  end
end
