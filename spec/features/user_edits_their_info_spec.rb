feature "user edits their user information", %{
  As a user,
  I want to edit my personal information,
  So it can be up to date.

  Acceptance Criteria:
  [] I can see that I am on the edit page
  [] When I log in, I can see my information prepopulated
  [] If my information is successfully updated, i am redirected to my user profile
      see a success message.
  [] If not, I am redirected back to the edit page and see an error message

} do
  let (:test_user) do
    FactoryGirl.create(:user)
  end
  scenario "user successfully updates user information" do
    sign_in_as(test_user)

    visit user_path(test_user)

    click_link "Edit Profile"

    expect(page).to have_content "Edit Player Profile"

    fill_in "First Name", with: "John"
    fill_in "Last Name", with: "Clucas"
    fill_in "Current password", with: test_user.password

    click_on "Save Player Information"

    expect(page).to have_content "Your account has been updated successfully."

    expect(page).to have_content "John Clucas"
  end
end
