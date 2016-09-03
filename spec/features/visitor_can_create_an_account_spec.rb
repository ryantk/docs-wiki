require 'rails_helper'

feature 'Visitor can create an account' do
  
  scenario 'Registering visitor has account created' do
    visit new_users_path
    fill_in 'Email', with: 'test@user.com'
    fill_in 'Username', with: 'test123'
    fill_in 'Password', with: 'super-strong-password'
    fill_in 'Password Confirmation', with: 'super-strong-password'
    click_button 'Register'

    users = User.where(username: 'test123')

    expect(users.count).to eq(1)

    user = users.first

    expect(user.email).to eq('test@user.com')
  end

end