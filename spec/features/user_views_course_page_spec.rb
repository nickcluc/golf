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

    sign_in_as(test_user)

    visit new_course_path

    fill_in "Name", with: test_course.name
    fill_in "Street Address", with: test_course.street_address
    fill_in "City", with: test_course.city
    select test_course.state, from: "State"
    fill_in "Zip Code", with: test_course.zip_code

    click_on "Create Course"

    expect(page).to have_content "Course created successfully!"

    expect(page).to have_content test_course.name
  end
