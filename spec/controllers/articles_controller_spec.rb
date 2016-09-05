require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'returns all Articles when no search criteria is passed' do
      all_articles = 3.times.map { Article.create }
      get :index
      expect(assigns(:articles)).to eq(all_articles)
    end

    it 'returns a subsection of articles based on title when search criteria is passed (case insensitive)' do
      article1 = Article.create(title: 'cool article about Dog')
      article2 = Article.create(title: 'cool article about cat')
      article3 = Article.create(title: 'cool article about Hot Dogs')

      get :index, q: 'dog'

      articles = assigns(:articles)
      expect(articles).to include(article1)
      expect(articles).to include(article3)
      expect(articles).not_to include(article2)
    end
  end

end
