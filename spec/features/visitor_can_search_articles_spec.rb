require 'rails_helper'

feature 'Visitor can view list of articles' do

  scenario 'Vistor entering a search term sees Articles with a similar title' do
    expect_to_see = [
      Article.create(title: 'Assembler for Rubyists'),
      Article.create(title: 'Using Openstruct in Ruby'),
      Article.create(title: 'Cool features of Ruby on Rails')
    ]
    expect_not_to_see = [
      Article.create(title: 'Javascript, the good parts'),
      Article.create(title: 'COBOL for beginners'),
      Article.create(title: 'Always code your own encryption algorithms')
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

  def is_article_visible_on_page?(article)
    find('.article', text: article.title).present?
  rescue Capybara::ElementNotFound
    false
  end

end