require 'rails_helper'

feature 'Visitor can log out' do
  
  scenario 'Logged in user can log out of account' do
    generate_test_user
    log_in_user
    
    log_out

    expect(page).to have_text(I18n.t('log_out.success'))
  end

end