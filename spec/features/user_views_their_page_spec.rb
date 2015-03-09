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
    sign_in_as(test_user)

    visit user_path(test_user)
    expect(page).to have_content test_user.full_name
    expect(page).to have_content test_user.email
    expect(page).to have_content "Upcoming Tee Times"
    expect(page).to have_content @future_round.round_date.strftime("%m/%d/%Y")
    expect(page).to have_content @past_round.round_date.strftime("%m/%d/%Y")
    expect(page).to have_content "Unscored Rounds"
  end
  (5..20).each do |i|
    scenario "user sees their handicap based on rounds count" do
      sign_in_as(test_user)
      i.times do
        FactoryGirl.create(:player_round, user_id: test_user.id)
      end
      visit user_path(test_user)
      expect(page).to have_content test_user.handicap
    end
  end

end
