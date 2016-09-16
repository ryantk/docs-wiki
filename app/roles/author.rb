module Author

  def author_new_article(article_details = {})
    self.articles.create(article_details)
  end

end
