require 'rails_helper'

feature 'Visitor can view list of articles' do

  scenario 'Vistor entering a search term sees Articles with a similar title' do
    author = User.create(username: 'author123', password: 'not-logging-in')
    
    expect_to_see = [
      Article.create(title: 'Assembler for Rubyists', body: 'test article', author: author),
      Article.create(title: 'Using Openstruct in Ruby', body: 'test article', author: author),
      Article.create(title: 'Cool features of Ruby on Rails', body: 'test article', author: author),
    ]
    expect_not_to_see = [
      Article.create(title: 'Javascript, the good parts', body: 'test article', author: author),
      Article.create(title: 'COBOL for beginners', body: 'test article', author: author),
      Article.create(title: 'Always code your own encryption algorithms', body: 'test article', author: author),
    ]

    visit articles_path

    # first we see all articles
    (expect_to_see + expect_not_to_see).each do |article| 
      expect(is_article_visible_on_page? article).to be(true)
    end

    # then we search
    find('#search').set('ruby')
    find('#search-submit').click

    # then we check
    expect_to_see.each do |article| 
      expect(is_article_visible_on_page? article).to be(true)
    end

    expect_not_to_see.each do |article| 
      expect(is_article_visible_on_page? article).not_to be(true)
    end
  end

end