require 'rails_helper'

describe User do
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:password) }
  it { should validate_length_of(:password).is_at_least(5) }
end
