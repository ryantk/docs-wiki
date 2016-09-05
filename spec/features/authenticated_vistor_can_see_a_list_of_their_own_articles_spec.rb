require 'rails_helper'

feature 'Authenticated visitor can see a list of their own articles' do
  
  scenario 'user with published articles sees them in a list' do
    generate_test_user
    other_author = User.create(username: 'author123', password: 'not-logging-in')

    my_articles = [
      Article.create(title: 'Article 1', body: 'Long passage of text', author: @user),
      Article.create(title: 'Article 2', body: 'Long passage of text', author: @user),
    ]
    other_authors_articles = [
      Article.create(title: 'Article 3', body: 'Long passage of text', author: other_author),
      Article.create(title: 'Article 4', body: 'Long passage of text', author: other_author),
    ]

    # log in user
    log_in_user

    # go to look at articles
    visit my_articles_path

    # check I see my articles
    my_articles.each {|article| expect(is_article_visible_on_page? article).to be(true) }

    # check I dont see other peoples articles
    other_authors_articles.each {|article| expect(is_article_visible_on_page? article).to be(false) }
  end

end