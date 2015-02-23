require "rails_helper"

feature "User adds a new round", %{
  As a user,
  I want to add a round I played,
  So I can keep track of my scores.

  Acceptance Criteria
  [ ] A new round needs a course, date, and tee time
  [ ] A new played round needs to have a score, tee, and how many holes played.
  [ ] After round is created, should see a success message and see it  pending on their user page
  [ ] After a round is played, Player should be able to add their scores and holes played
  [ ] Completed rounds should be listed on user page as well
} do
  let (:test_tee) do
    FactoryGirl.create(:tee)
  end

  scenario "User successfully creates a new round" do
    test_round = FactoryGirl.build(:round)
    test_tee = FactoryGirl.create(:tee, course: test_round.course)
    sign_in_as(test_tee.course.user)

    visit new_round_path

    fill_in "Date", with: test_round.round_date
    select test_tee.course.name, from: "Course", match: :first
    fill_in "Tee Time", with: test_round.tee_time
    click_on "Create Round"

    expect(page).to have_content "Round Created Successfully!"

    fill_in "Number of Holes", with: 18
    fill_in "Score", with: 80
    save_and_open_page
    select test_tee.color, from: "Tee"

    click_on "Save Score"

    expect(page).to have_content "Score Saved Successfully!"
  end
end
