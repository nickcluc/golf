require 'spec_helper'

describe Hole do
  it { should belong_to :course }

  it { should have_valid(:course).when(Course.new) }
  it { should_not have_valid(:course).when(nil) }

  it { should have_valid(:number).when(9) }
  it { should_not have_valid(:number).when(20) }
  it { should_not have_valid(:number).when(10.5) }
  it { should_not have_valid(:number).when('steve') }
  it { should_not have_valid(:number).when(nil) }

  it { should have_valid(:handicap).when(18) }
  it { should_not have_valid(:handicap).when(10.5) }
  it { should_not have_valid(:handicap).when(35) }
  it { should_not have_valid(:handicap).when('steve') }
  it { should_not have_valid(:handicap).when(nil) }

  it { should have_valid(:yardage).when(350) }
  it { should_not have_valid(:yardage).when(350.5) }
  it { should_not have_valid(:yardage).when('steve') }
  it { should_not have_valid(:yardage).when(nil) }

  it 'is the hardest hole on the course' do
    hole = FactoryGirl.create(:hole, handicap: 1)
    expect(hole.hardest?).to be true
  end

  it 'is the easiest hole on the course' do
    hole = FactoryGirl.create(:hole, handicap: 18)
    expect(hole.easiest?).to be true
  end

  it 'is not the hardest or easiest hole on the course' do
    hole = FactoryGirl.create(:hole, handicap: 11)
    expect(hole.easiest?).to be false
    expect(hole.hardest?).to be false
  end

  it 'is the longest hole on the course' do
    course = FactoryGirl.create(:course)
    hole1 = FactoryGirl.create(:hole, yardage: 180, course: course)
    hole2 = FactoryGirl.create(:hole, yardage: 300, course: course)
    expect(hole2.longest?).to be true
    expect(hole1.longest?).to be false
  end
end
