class AuthorNewArticleContext

  attr_reader :user, :article_details

  def self.call(user, article_details = {})
    AuthorNewArticleContext.new(user, article_details).call
  end

  def initialize(user, article_details = {})
    @user = user
    # User assumes role of Author
    @user.extend Author

    @article_details = article_details
  end

  def call
    user.author_new_article(article_details)
  end

end
