require 'rails_helper'

feature 'Authenticated visitor can modify an Article they authrored' do
  
  scenario 'Authenticated visitor on detail page of thwir own Article can modify it' do
    generate_test_user
    log_in_user

    article = Article.create(title: 'An Exiting Article', body: 'Article Body', author: @user)

    # when I navigate to the list of articles
    visit articles_path

    # and I click to see the article detail
    find_article_on_page(article).click

    # and I click to edit the Article
    click_link 'Edit'

    # and I enter a new title
    fill_in 'Title', with: 'New Title'
    fill_in 'Article Body', with: 'New Body'
    click_button 'Save'

    # then I navigate to the list of articles
    visit articles_path

    # and I dont see my old Article
    expect(is_article_visible_on_page? article).to be(false)

    # and I see my new Article on the page
    expect(is_article_visible_on_page? Article.new(title: 'New Title', body: 'New Body')).to be(true)
  end

  scenario 'Authenticated visitor cannot modify another authors Article' do
    generate_test_user
    log_in_user

    other_author = User.create(username: 'anotherUser', password: 'noImportant')
    article = Article.create(title: 'Not My Post', body: 'Not My Post Body', author: other_author)

    # when I navigate to the list of articles
    visit articles_path

    # and I click to see the article detail
    find_article_on_page(article).click

    # then I cant see the edit button
    expect(page).not_to have_button('Edit')

    # and I cant even navigate to the edit route manually
    visit edit_article_path(article)
    expect(page.current_url).not_to eq(edit_article_url(article))
  end

end