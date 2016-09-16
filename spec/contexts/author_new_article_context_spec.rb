require 'rails_helper'

describe AuthorNewArticleContext do

  let(:user) { User.new }
  let(:article_details) { { title: 'Article Title', body: 'Article Body' } }

  it 'passes the correct arguments to the role' do
    context = AuthorNewArticleContext.new(user, article_details)
    user.should_receive(:author_new_article).with(article_details)
    context.call
  end

end
