require 'rails_helper'

feature 'Visitor can log in' do
  
  scenario 'Registered user can log into account' do
    @user = generate_test_user
    log_in_with(username: @user.username, password: @user.password)

    expect(page).to have_text(I18n.t('authentication.success'))
    expect(page).to have_text(@user.username)
  end

end