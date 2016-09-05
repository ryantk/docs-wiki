require 'rails_helper'

feature 'Visitor can view list of articles' do
  
  scenario 'Visitor sees list of articles' do
    article1 = Article.create(title: 'Really great peice of information')
    article2 = Article.create(title: 'Quite a good peice of information')
    article3 = Article.create(title: 'A third superb peice of information')

    visit articles_path
    expect(page).to have_content('All Articles')
    expect(page).to have_content(article1.title)
    expect(page).to have_content(article2.title)
    expect(page).to have_content(article3.title)
  end

end