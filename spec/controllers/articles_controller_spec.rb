require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do

  describe 'GET #new' do
    it 'redirects to root_path if no user is logged in' do
      get :new
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'GET #my_articles' do
    it 'redirects to root_path if no user is logged in' do
      get :my_articles
      expect(response).to redirect_to(root_path)
    end

    it 'renders the same template as index' do
      controller.sign_in_user(User.new)
      get :my_articles
      expect(response).to render_template(:index)
    end

    it 'renders all articles for the current user' do
      user = User.new(username: 'topUser', password: 'password123')
      3.times {|i| user.articles.build title: "Article #{i}", body: "Body of Article #{i}" }
      controller.sign_in_user(user)

      get :my_articles

      expect(assigns(:articles)).to eq(user.articles)
    end
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'returns all Articles when no search criteria is passed' do
      all_articles = 3.times.map { Article.create(title: 'test', body: 'test', author: GuestUser.new) }
      get :index
      expect(assigns(:articles)).to eq(all_articles)
    end

    it 'returns a subsection of articles based on title when search criteria is passed (case insensitive)' do
      article1 = Article.create(title: 'cool article about Dog', body: 'test', author: GuestUser.new)
      article2 = Article.create(title: 'cool article about cat', body: 'test', author: GuestUser.new)
      article3 = Article.create(title: 'cool article about Hot Dogs', body: 'test', author: GuestUser.new)

      get :index, q: 'dog'

      articles = assigns(:articles)
      expect(articles).to include(article1)
      expect(articles).to include(article3)
      expect(articles).not_to include(article2)
    end
  end

  describe 'POST #create' do
    context 'with valid data' do
      before :each do
        @data = {
          article: {
            title: 'My First Article',
            body: 'A long passage of text'
          }
        }
        
      end

      it 'creates the Article object' do
        post :create, @data

        expect(Article.count).to eq(1)
        article = Article.first
        expect(article.title).to eq(@data[:article][:title])
        expect(article.body).to eq(@data[:article][:body])
      end

      it 'links the article to the currently logged in User' do
        user = User.create(username: 'author1', password: 'not-important')
        controller.sign_in_user(user)

        post :create, @data

        article = Article.first
        expect(article.author).to eq(user)
      end
    end

    context 'with invalid data' do
      it 'renders :new with an error message' do
        post :create # no data
        expect(response).to render_template(:new)
        expect(flash[:alert]).to eq(I18n.t('articles.create.failure'))
      end
    end
  end

end
