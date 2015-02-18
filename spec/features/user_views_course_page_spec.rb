require "rails_helper"

feature "user views a course", %{
  As a user,
  I want to view a course details,
  So that I can play a round of golf there.

  Acceptance Criteria:
  [ ] I must see the course name, address & phone number if available.
  [ ] A user can add tees as needed (blue, white, sr, ladies, etc.)
  [ ] If i added the course, I should see a link to edit the course
  [ ] If i created the course, i should be able to delete the course.
} do

  let (:test_user) do
    FactoryGirl.create(:user)
  end

  let (:test_course) do
    FactoryGirl.create(:course)
  end

  scenario "User Successfully adds a course" do

    sign_in_as(test_course.user)

    visit course_path(test_course)

    expect(page).to have_content test_course.name
    expect(page).to have_content test_course.street_address
    expect(page).to have_content test_course.city
    expect(page).to have_content test_course.state
    expect(page).to have_content test_course.zip_code
  end
end
