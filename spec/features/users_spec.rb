require 'rails_helper'

feature 'User management' do
  scenario 'adds a new user' do
    admin = create(:admin)

    visit root_path
    click_link 'Log In'
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: admin.password
    click_button 'Log In'

    visit root_path

    expect {
      click_link 'Users'
      click_link 'New User'
      fill_in 'Email', with: 'nowyjuzer@example.com'
      find('#password').fill_in 'Password', with: 'adamnowak12'
      find('#password_confirmation').fill_in 'Password confirmation',
        with: 'adamnowak12'
      click_button 'Create User'
    }.to change(User, :count).by(1)
    expect(current_path).to eq users_path
    expect(page).to have_content 'New user created'

    within 'h1' do
      expect(page).to have_content 'Users'
    end
    expect(page).to have_content 'nowyjuzer@example.com'
  end
end
