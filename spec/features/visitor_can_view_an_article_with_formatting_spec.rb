require 'rails_helper'

feature 'Visitor can view detail view of an Article' do
  
  scenario 'Visitor on Article detail view sees formatting' do
    article_title = 'Article with formatting'
    article_body = <<-ARTICLE
# Title
## Sub Title

_this text is italic_
**this text is strong**

    def method(points)
      var x, y, z = *points
      x + y * z
    end
    ARTICLE

    generate_test_user
    article = Article.create(title: article_title, body: article_body, author: @user)
    log_in_user

    # when I navigate to the list of articles
    visit articles_path

    # and I click to see the article detail
    find_article_on_page(article).click

    # then I see the following detail of the article
    expect(page).to have_text(article.title)

    within('#article-body-formatted') do
      expect(page).to have_selector('h1', text: 'Title')
      expect(page).to have_selector('h2', text: 'Sub Title')
      expect(page).to have_selector('em', text: 'this text is italic')
      expect(page).to have_selector('strong', text: 'this text is strong')
      expect(page).to have_selector('code.prettyprint', text: 'def method(points) var x, y, z = *points x + y * z end')
    end
  end

end