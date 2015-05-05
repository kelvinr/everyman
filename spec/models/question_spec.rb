require 'rails_helper'

describe Question do
  it { should belong_to(:user) }

  it { should validate_presence_of(:question) }
  it { should validate_presence_of(:user) }
end
