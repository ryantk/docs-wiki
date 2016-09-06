class ArticlesController < ApplicationController
  before_action :require_login, except: [:index, :show]

  def new
    @article = Article.new
  end

  def index
    if criteria.present?
      @articles = Article.where('lower(title) LIKE ?', "%#{criteria.downcase}%")
    else
      @articles = Article.all
    end
  end

  def show
    @article = Article.find(params[:id])
    
  rescue
    flash[:alert] = I18n.t('articles.show.could_not_be_found')
    redirect_to articles_path
  end

  def my_articles
    @articles = current_user.articles
    @title = "#{current_user.username}'s Articles"
    render :index
  end

  def create
    @article = current_user.articles.build(article_params)
    @article.save!

    flash[:success] = I18n.t('articles.create.success')
    redirect_to article_path(@article)

  rescue
    flash.now[:alert] = I18n.t('articles.create.failure')
    render :new
  end

  def edit
    @article = Article.find(params[:id])
    redirect_to article_path(@article) and return unless @article.author == current_user
  end

  def update
    @article = Article.find(params[:id])

    unless @article.author == current_user
      redirect_to article_path(@article) and return
    end

    if @article.update_attributes(article_params)
      flash[:success] = I18n.t('articles.update.success')
      redirect_to article_path(@article)
    else
      flash.now[:alert] = I18n.t('articles.update.failure')
      render :update
    end
  end

  private

  def criteria
    params[:q]
  end

  def article_params
    params.require(:article).permit(:title, :body)
  end
end
