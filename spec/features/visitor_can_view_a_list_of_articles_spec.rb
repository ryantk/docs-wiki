require 'rails_helper'

feature 'Visitor can view list of articles' do
  
  scenario 'Visitor sees list of articles' do
    author = User.create(username: 'author123', password: 'not-logging-in')

    article1 = Article.create(title: 'Really great peice of information', body: 'test article', author: author)
    article2 = Article.create(title: 'Quite a good peice of information', body: 'test article', author: author)
    article3 = Article.create(title: 'A third superb peice of information', body: 'test article', author: author)

    visit articles_path
    expect(page).to have_content('All Articles')
    expect(page).to have_content(article1.title)
    expect(page).to have_content(article2.title)
    expect(page).to have_content(article3.title)
  end

end