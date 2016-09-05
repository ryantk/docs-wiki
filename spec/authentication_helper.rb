module AuthenticationHelper

  def log_in_with(attributes = {})
    visit log_in_path
    fill_in 'Username', with: attributes.fetch(:username)
    fill_in 'Password', with: attributes.fetch(:password)
    click_button 'Log In'
  end

  def log_out
    click_link 'Log Out'
  end

end