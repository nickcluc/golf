require "rails_helper"

feature "User adds friends", %{
  AS a user,
  I want to add friends
  So I can view their scores more easily

  Acceptance Criteria:
  [ ] I can search for users by their email address or full name
  [ ] I can request people to be friends with from their profile page
  [ ] If they approve request, I should see the friend on my user profile
  [ ] Friends can be added to rounds that you have planned or have played.
} do

  before :each do
    @test_user_one = FactoryGirl.create(:user)

    User.searchkick_index.refresh
    @test_user_two = FactoryGirl.create(:user, first_name: "Michael")

    User.searchkick_index.refresh
  end

  scenario "two users successfully become friends" do
    sign_in_as(@test_user_one)

    visit user_path(@test_user_two)

    click_link "Add Friend"

    expect(page).to have_content "Friend Request to #{@test_user_two.full_name} Sent!"

    click_link "Sign Out"

    sign_in_as(@test_user_two)

    expect(page).to have_content "New Friend Request!"

    click_link "Accept"

    expect(page).to have_content "Friendship Accepted"

    click_link @test_user_one.full_name
    expect(current_path) == user_path(@test_user_one)
  end

  scenario "user rejects friend request" do
    sign_in_as(@test_user_one)

    visit user_path(@test_user_two)

    click_link "Add Friend"

    click_link "Sign Out"

    sign_in_as(@test_user_two)

    click_link "Ignore"

    expect(page).to have_content "Friend Request From #{@test_user_one.full_name} Ignored"
    expect(page).to_not have_content "New Friend Request!"
    visit user_path(@test_user_two)
    expect(page).to_not have_content @test_user_one.full_name
  end
  scenario "two users try to friend each other" do
    sign_in_as(@test_user_one)

    visit user_path(@test_user_two)

    click_link "Add Friend"

    click_link "Sign Out"

    sign_in_as(@test_user_two)

    visit user_path(@test_user_two)

    expect(page).to_not have_content "Add Friend"
  end
end
