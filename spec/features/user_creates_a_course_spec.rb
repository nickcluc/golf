require "rails_helper"

feature "user creates a course", %{
  As a user,
  I want to add a course to the system,
  So that I can play a round of golf there.

  Acceptance Criteria:
  [ ] A course must have a name, address, city, state, and zipcode.
  [ ] A user can add tees as needed (blue, white, sr, ladies, etc.)
  [ ] When successfully added, I should see a success message and the course information.
  [ ] When unsuccessful, I should see an error message and the form.
  [ ] A user must be logged in to create a course, if not, should see error.
} do
  
  let (:test_user) do
    FactoryGirl.create(:user)
  end

  scenario "User Successfully adds a course" do
    test_course = FactoryGirl.build(:course)

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

  scenario "User unsuccessfully adds a course" do
    sign_in_as(test_user)

    visit new_course_path

    click_on "Create Course"

    expect(page).to have_content "can't be blank"

  end

end
