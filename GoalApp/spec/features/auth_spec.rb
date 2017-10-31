require 'spec_helper'
require 'rails_helper'

feature 'the signup process' do
  scenario 'has a new user page' do
    #  "has username field"
    # it "has password field"
    # it "clicks Sign Up button"

    visit new_user_path
    expect(page).to have_content 'New User'
    expect(page).to have_content 'Username'
    expect(page).to have_content 'Password'
  end

  feature 'signing up a user' do

    scenario 'shows username on the homepage after signup' do
      visit new_user_path
      fill_in "Username", with: 'bob'
      fill_in "Password", with: 'password'
      click_button "Sign Up"

      expect(page).to have_content 'bob'
    end

  end
end

feature 'logging in' do
  scenario 'shows username on the homepage after login' do
    User.create!(username: 'bob', password: 'password')

    visit new_session_path
    fill_in "Username", with: 'bob'
    fill_in "Password", with: 'password'
    click_button "Log In"

    expect(page).to have_content 'bob'
  end

end

feature 'logging out' do
  scenario 'begins with a logged out state' do
    visit goals_index_path
    expect(current_path).to eq(new_session_path)
  end

  scenario 'doesn\'t show username on the homepage after logout' do
    User.create!(username: 'bob', password: 'password')

    visit new_session_path
    fill_in "Username", with: 'bob'
    fill_in "Password", with: 'password'
    click_button "Log In"

    click_button "Log Out"
    expect(page).not_to have_content 'bob'
  end

end
