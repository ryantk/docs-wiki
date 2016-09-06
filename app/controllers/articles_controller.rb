class ArticlesController < ApplicationController
  def new
    redirect_to root_path and return unless user_signed_in?
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
  end

  def my_articles
    redirect_to root_path and return unless user_signed_in?
    @articles = current_user.articles
    @title = "#{current_user.username}'s Articles"
    render :index
  end

  def create
    @article = current_user.articles.build(article_params)

    if @article.save
      flash[:success] = I18n.t('articles.create.success')
      redirect_to article_path(@article)
    else
      flash.now[:alert] = I18n.t('articles.create.failure')
      render :new
    end

  rescue
    flash.now[:alert] = I18n.t('articles.create.failure')
    render :new
  end

  def edit
    redirect_to root_path and return unless user_signed_in?
    @article = Article.find(params[:id])
    redirect_to article_path(@article) and return unless @article.author == current_user
  end

  def update
    redirect_to root_path and return unless user_signed_in?
    @article = Article.find(params[:id])
    redirect_to article_path(@article) and return unless @article.author == current_user

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
