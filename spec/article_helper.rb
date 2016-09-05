module ArticleHelper

  def is_article_visible_on_page?(article)
    find_article_on_page(article).present?
  rescue Capybara::ElementNotFound
    false
  end

  def author_for_article(article)
    find_article_on_page(article).find('.author').text
  end

  def find_article_on_page(article)
    find('.article', text: article.title)
  end

end