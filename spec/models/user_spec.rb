require 'rails_helper'

RSpec.describe User, type: :model do
  it "returns a user's full name" do
    user = FactoryGirl.create(:user)
    expect(user.full_name) == "Nick Clucas"
  end
end
