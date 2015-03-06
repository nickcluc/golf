feature "User removes friends", %{
  As a user,
  I want to remove friends
  So to that they cannot see my score information.

  Acceptance Criteria:
  [ ] I can see a list of all my friends with a link to remove them, or i can remove them from their user page
  [ ] I should be redirected to my user page and see a message confirming the removal.
} do

  before :each do
    @test_user_one = FactoryGirl.create(:user)
    @test_user_one.reindex
    User.searchkick_index.refresh
    @test_user_two = FactoryGirl.create(:user, first_name: "Michael")
    @test_user_two.reindex
    User.searchkick_index.refresh
    sign_in_as(@test_user_one)
    visit user_path(@test_user_two)
    click_link "Add Friend"
    click_link "Sign Out"
    sign_in_as(@test_user_two)
    click_link "Accept"
    visit user_friendships_path(@test_user_one)
    expect(page).to have_content @test_user_two.full_name
  end

  scenario "user successfully removes a friendship from a user page" do
    click_link "Sign Out"
    sign_in_as(@test_user_one)
    click_link @test_user_two.full_name

    click_link "Unfriend"
    visit user_path(@test_user_two)
    expect(page).to_not have_content @test_user_one.full_name

    visit user_path(@test_user_one)
    expect(page).to_not have_content @test_user_two.full_name

    visit user_friendships_path(@test_user_one)
    expect(page).to_not have_content @test_user_two.full_name
  end

  scenario "user removes a friendship from the user friendships page" do
    click_link "Unfriend"
    visit user_path(@test_user_two)
    expect(page).to_not have_content @test_user_one.full_name

    visit user_path(@test_user_one)
    expect(page).to_not have_content @test_user_two.full_name

    visit user_friendships_path(@test_user_one)
    expect(page).to_not have_content @test_user_two.full_name
  end
end
