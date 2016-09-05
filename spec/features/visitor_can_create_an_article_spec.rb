require 'rails_helper'

feature 'Visitor can create an article' do
  
  scenario 'Vistor authoring Article has it saved against their User' do
    article_title = 'My First Article'
    article_body = <<-ARTICLE
      Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
    ARTICLE

    # log in user
    generate_test_user
    log_in_user

    # go to create an article
    visit articles_path
    click_link 'New Article'

    # enter our article details
    fill_in 'Title', with: article_title
    fill_in 'Article Body', with: article_body
    click_button 'Publish'

    # check we can see it on the front end
    test_article = Article.new(title: article_title, body: article_body)

    visit articles_path
    expect(is_article_visible_on_page? test_article).to be(true)
    expect(author_for_article test_article).to eq(@user.username)
  end

end