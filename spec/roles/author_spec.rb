require 'rails_helper'

describe Author do

  let(:user) { User.create(username: 'test@user', password: 'testUser123') }
  let(:article_details) { { title: 'Article Title', body: 'Article Body' } }

  before :each do
    user.extend Author
  end

  describe '#author_new_article' do
    it 'creates a new Article object with the details and links it to the User' do
      user.author_new_article(article_details)

      expect(user.articles.size).to eq(1)
      expect(user.articles.first.title).to eq(article_details[:title])
      expect(user.articles.first.body).to eq(article_details[:body])
    end
  end

end
