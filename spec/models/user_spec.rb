require 'rails_helper'

describe User do
  it "returns a user's full name" do
    user = FactoryGirl.create(:user)
    expect(user.full_name) == 'Nick Clucas'
  end

  it { should have_many(:posts).dependent(:destroy) }
end
