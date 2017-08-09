require 'rails_helper'

feature 'User management' do
  scenario 'adds a new user' do
    admin = create(:admin)
    sign_in(admin)

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

    # save_and_open_page

    expect(current_path).to eq users_path
    expect(page).to have_content 'New user created'

    within 'h1' do
      expect(page).to have_content 'Users'
    end
    expect(page).to have_content 'nowyjuzer@example.com'
  end
end
