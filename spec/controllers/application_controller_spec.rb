require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do

  describe '#user_signed_in?' do
    it 'returns true if current_user is present' do
      controller.stub(:current_user) { anything }
      expect(controller.user_signed_in?).to be(true)
    end

    it 'returns false if current_user is nil' do
      controller.stub(:current_user) { nil }
      expect(controller.user_signed_in?).to be(false)
    end
  end

  describe '#sign_in_user' do
    it 'saves the given users id into the session for later retrieval' do
      user = double(id: '123')
      controller.sign_in_user(user)

      expect(session[:current_user_id]).to eq(user.id)
    end
  end

  describe '#sign_out_user' do
    before :each do
      # first sign in a user
      user = double(id: '123')
      controller.sign_in_user(user)
    end

    it 'removes current_user_id from the session' do
      controller.sign_out_user
      expect(session[:current_user_id]).not_to be_present
    end

    it 'sets the current_user to nil' do
      controller.sign_out_user
      expect(controller.current_user).to be(nil)
    end
  end

  describe '#current_user' do
    it 'returns the User with the same id as stored in session' do
      user_id = '123'
      user = double(id: user_id)
      allow(User).to receive(:find_by).with(id: user_id).and_return(user)

      session[:current_user_id] = user_id

      expect(controller.current_user).to eq(user)
    end

    it 'returns nil if there is no User to be found' do
      user_id = '123'
      session[:current_user_id] = user_id

      expect(controller.current_user).to eq(nil)
    end
  end

end