require 'spec_helper'
require 'rails_helper'

feature 'Create a goal!' do
  before(:each) do
    sign_in_with('bob', 'password')
  end

  scenario 'has a new goal page' do
    visit new_goal_path
    expect(page).to have_content 'New Goal'
    expect(page).to have_content 'Title'
    expect(page).to have_content 'Body'
    expect(page).to have_content 'Privacy'
  end

  scenario 'shows the new goal on homepage' do
    add_goal1

    expect(page).to have_content 'A new goal!'
  end
end

feature "See goal's page" do
  before(:each) do
    sign_in_with('bob', 'password')
    add_goal1
    click_link('A new goal!')
  end

  scenario "click to goal's page" do
    expect(page).to have_content('learn capybara')
  end

  scenario "can return to homepage" do
    click_link('Back to Goals')

    expect(page).to have_content('Public Goals')
  end

  scenario "can edit goal" do
    click_link('Edit Goal')

    expect(page).to have_content('Update Goal')
  end

  scenario 'goal is updated' do
    click_link('Edit Goal')

    fill_in "Title", with: 'My favorite goal!'
    click_button "Update Goal"

    expect(page).to have_content('My favorite goal!')
    expect(page).not_to have_content('A new goal!')
  end
end

feature "Delete a goal" do
  before(:each) do
    sign_in_with('bob', 'password')
    add_goal1
  end

  scenario "Goal is removed from homepage" do
    click_button('Remove Goal')

    expect(page).to have_content('Public Goals')
    expect(page).not_to have_content('A new goal!')
  end
end

feature 'Private goals' do
  before(:each) do
    sign_in_with('bob', 'password')
    add_goal1
    add_goal2
  end

  scenario 'Can see own goal' do
    expect(page).to have_content('Goal 2')
  end

  scenario "Cannot see other user's private goal" do
    click_button('Log Out')
    sign_in_with('elizabeth', 'password')

    expect(page).not_to have_content('Goal 2')
  end
end
