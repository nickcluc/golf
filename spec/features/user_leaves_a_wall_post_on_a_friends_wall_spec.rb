require "rails_helper"

feature "User Leaves a Wall Post", %{
  As a user,
  I want to leave a wall post on a friend's wall,
  So that I can tell him how much better at golf I am.

  Acceptance Criteria:
  [] I can only leave wall posts on a friend's wall.
  [] Wall posts canot be longer than 140 characters
  [] If the post is successful, I can see it once it is posted.
  [] I should not be able to post the message if it is invalid

} do
  let (:test_user_one) do
    FactoryGirl.create(:user)
  end
  let (:test_user_two) do
    FactoryGirl.create(:user)
  end

  scenario "user successfully posts to a friend's wall" do
    sign_in_as(test_user_one)

    visit user_path(test_user_two)

    within("div#wall_post_form") do
      fill_in "Wall Post", with: "You stink at golf!"
      click_on "Post"
    end
    within("div.wall_post") do
      expect(page).to have_content "You stink at golf!"
    end
  end

  scenario "user unsuccessfully posts to a friend's wall" do
    sign_in_as(test_user_one)

    visit user_path(test_user_two)

    within("div#wall_post_form") do
      click_on "Post"
    end

    expect(page).to have_content "can't be blank"
  end
end
