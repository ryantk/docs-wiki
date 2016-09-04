require 'rails_helper'

feature 'Visitor can log in' do
  
  scenario 'Registered user can log into account' do
    username = 'test123'
    password = 'super-strong-password'
    User.create!(username: username, password: password)

    visit log_in_path
    fill_in 'Username', with: username
    fill_in 'Password', with: password
    click_button 'Log In'

    expect(page).to have_text(I18n.t('authentication.success'))
    expect(page).to have_text(username)
  end

end