require 'rails_helper'

RSpec.describe UserSessionsController, type: :controller do

  describe 'POST #create' do

    context 'with invalid data' do
      before :each do
        post :create # nothing!
      end

      it 'renders new with an error' do
        expect(response).to render_template(:new)
        expect(flash[:alert]).to eq(I18n.t('authentication.failure.missing_data'))
      end
    end

    context 'with valid data' do
      before :each do
        @data = {
          username: 'tester123',
          password: 'super-duper-password'
        }
      end

      context 'User exists for given username with matching password' do
        before :each do
          @user = User.create(@data)
          post :create, @data
        end

        it 'logs in the user' do
          expect(controller.user_signed_in?).to be(true)
          expect(controller.current_user.id).to eq(@user.id)
        end

        it 'redirects to the articles index' do
          expect(response).to redirect_to(articles_path)
        end
      end

      context 'User exists for given username but password is incorrect' do
        before :each do
          create_user_data = @data.dup
          create_user_data[:password] = 'completely-wrong'
          @user = User.create(create_user_data)

          post :create, @data
        end

        it 'renders new with an error' do
          expect(response).to render_template(:new)
          expect(flash[:alert]).to eq(I18n.t('authentication.failure.incorrect_password'))
        end
      end

      context 'User doesnt exist for given username' do
        before :each do
          post :create, @data
        end

        it 'renders new with an error' do
          expect(response).to render_template(:new)
          expect(flash[:alert]).to eq(I18n.t('authentication.failure.no_such_user_with_username', username: @data[:username]))
        end
      end
    end

  end

end
