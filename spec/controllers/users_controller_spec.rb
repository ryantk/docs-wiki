require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe 'POST #create' do

    context 'with valid data' do
      before :each do
        @user_data = { 
          email: 'test@email.com',
          username: 'test123', 
          password: 'super-strong123', 
          password_confirmation: 'super-strong123' 
        }

        post :create, { user: @user_data }

        @user = assigns(:user)
      end

      it { expect(@user.email).to eq(@user_data[:email]) }
      it { expect(@user.username).to eq(@user_data[:username]) }
      it { expect(User.count).to eq(1) }

      it 'redirects you to the list of articles' do
        expect(response).to redirect_to(articles_path)
      end

      it 'logs you into the system by default' do
        expect(controller.user_signed_in?).to be(true)
      end
    end

    context 'with invalid data' do
      before :each do
        @user_data = { 
          email: 'test@email.com',
          username: 'test123', 
          password: 'super-strong123', 
          password_confirmation: 'super-strong123-different' 
        }

        post :create, { user: @user_data }

        @user = assigns(:user)
      end

      it 'renders new again to try again' do
        expect(response).to render_template(:new)
      end

      it 'shows a message to the user' do
        expect(flash[:alert]).to be_present
      end
    end

  end

end
