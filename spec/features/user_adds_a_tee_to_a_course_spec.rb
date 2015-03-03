require "rails_helper"

feature "user adds a tee to a course", %{
  As a user,
  I want to add a tee to a course,
  So I can measure the difficulty of the course.

  Acceptance Criteria:
  [ ] A user cna only add a tee if they created the course
  [ ] A user can add tees as needed (blue, white, sr, ladies, etc.)
  [ ] When successfully added, I should see a success message and tee information.
  [ ] When unsuccessful, I should see an error message and the form.
} do
  let (:test_course) do
    FactoryGirl.create(:course)
  end
  scenario "user adds a tee succesfully" do
    test_tee = FactoryGirl.build(:tee)

    sign_in_as(test_course.user)

    visit course_path(test_course)

    expect(page).to have_content "Tees"

    fill_in "Color", with: test_tee.color
    fill_in "Rating", with: test_tee.rating
    fill_in "Slope", with: test_tee.slope
    fill_in "Yardage", with: test_tee.yardage

    click_on "Create Tee"

    expect(page).to have_content "Tee created successfully!"
  end
end
