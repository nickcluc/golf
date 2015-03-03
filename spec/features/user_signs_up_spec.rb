require 'rails_helper'

feature 'user registers', %Q{
  As a visitor
  I want to register
  So that I can create an account
} do

  # Acceptance Criteria:
  # * I must specify a valid email address,
  #   password, and password confirmation
  # * If I don't specify the required information, I am presented with
  #   an error message

  scenario 'provide valid registration information' do
    visit root_path

    within "#new_user" do
      fill_in 'Email', with: 'john@example.com'
      fill_in 'Password', with: 'password', match: :prefer_exact
      fill_in 'Password confirmation', with: 'password'

      click_button 'Sign Up'
    end

    expect(page).to have_content('Welcome! You have signed up successfully.')
    expect(page).to have_content('Sign Out')
  end

  scenario 'provide invalid registration information' do
    visit root_path

    click_button 'Sign Up'
    expect(page).to have_content("can't be blank")
    expect(page).to_not have_content('Sign Out')
  end
end
