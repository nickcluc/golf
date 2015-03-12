require "spec_helper"

describe Tee do
  it { should belong_to :user }
  it { should belong_to :course }

  it { should have_valid(:user).when(User.new) }
  it { should_not have_valid(:user).when(nil) }

  it { should have_valid(:course).when(Course.new) }
  it { should_not have_valid(:course).when(nil) }

  it { should have_valid(:color).when("White") }
  it { should_not have_valid(:color).when(nil) }

  it { should have_valid(:slope).when(68) }
  it { should_not have_valid(:slope).when(nil) }
  it { should_not have_valid(:slope).when("steve") }

  it { should have_valid(:rating).when(105.3) }
  it { should_not have_valid(:rating).when(nil) }
  it { should_not have_valid(:rating).when("steve") }

  it { should have_valid(:yardage).when(6000) }
  it { should_not have_valid(:yardage).when(nil) }
  it { should_not have_valid(:yardage).when("steve") }
end
