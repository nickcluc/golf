require "spec_helper"

describe Post do
  it { should belong_to :user }

  it { should have_valid(:user).when(User.new) }
  it { should_not have_valid(:user).when(nil) }

  it { should have_valid(:recipient).when(User.new) }
  it { should_not have_valid(:recipient).when(nil) }

  it { should have_valid(:body).when("m"*5) }
  it { should_not have_valid(:body).when("m"*141) }
end
