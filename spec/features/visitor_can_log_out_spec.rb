require 'rails_helper'

feature 'Visitor can log out' do
  
  scenario 'Logged in user can log out of account' do
    username = 'test123'
    password = 'super-strong-password'
    User.create!(username: username, password: password)

    log_in_with(username: username, password: password)
    log_out

    expect(page).to have_text(I18n.t('log_out.success'))
  end

end