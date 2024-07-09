class ArticlesController < ApplicationController
  # gets all the articles form the DB
  def index
    @articles = Article.all
  end

  # search for one article on DB given it's ID
  def show
    @article = Article.find(params[:id])
  end

  # this will be used for rendering new form
  def new
    @article = Article.new
  end

  # this actually creates a new article  if there's no errors
  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to '/'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # this will be used for rendering edit form for a given article
  def edit
    @article = Article.find(params[:id])
  end

  # this actually updates a given article if there's no errors
  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # this method destoy or delete a given article
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to root_path, status: :see_other
  end

  private

  # manages the params obtained from the new form
  def article_params
    params.require(:article).permit(:title, :body)
  end
end
