require "rails_helper"

feature "User views their page", %{
  As a user,
  I want to view my user page,
  So I can see my round and stats.
} do
  let (:test_user) do
    FactoryGirl.create(:user)
  end

  before (:each) do
    @future_round = FactoryGirl.create(:round, round_date: Date.today + 3, user_id: test_user.id)
    @past_round = FactoryGirl.create(:round, round_date: Date.today - 3, user_id: test_user.id)
  end

  scenario "User views their player page" do
    5.times do
      FactoryGirl.create(:player_round, user_id: test_user.id)
    end
    sign_in_as(test_user)

    visit user_path(test_user)
    expect(page).to have_content test_user.name
    expect(page).to have_content test_user.email
    expect(page).to have_content test_user.handicap
    expect(page).to have_content "Upcoming Rounds"
    expect(page).to have_content @future_round.round_date.strftime("%m/%d/%Y")
    expect(page).to have_content @past_round.round_date.strftime("%m/%d/%Y")
    expect(page).to have_content "Recently Finished Rounds"
  end

end
