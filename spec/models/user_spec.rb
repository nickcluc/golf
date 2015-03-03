require 'rails_helper'

RSpec.describe User, type: :model do
  it "returns a user's full name" do
    user = FactoryGirl.create(:user)
    user.full_name.should == "Nick Clucas"
  end
end
