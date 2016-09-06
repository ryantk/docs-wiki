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

  def generate_test_user
    username = 'test123'
    password = 'super-strong-password'
    email    = 'my@email.com'
    @user = User.create!(username: username, password: password, email: email)
  end

  def log_in_user
    raise 'Generate Test User first!' unless @user.present?
    log_in_with(username: @user.username, password: @user.password)
  end

end