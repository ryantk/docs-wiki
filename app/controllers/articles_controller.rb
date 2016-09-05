class ArticlesController < ApplicationController
  def index
    if criteria.present?
      @articles = Article.where('lower(title) LIKE ?', "%#{criteria.downcase}%")
    else
      @articles = Article.all
    end
  end

  private

  def criteria
    params[:q]
  end
end
