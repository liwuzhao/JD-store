class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy]


  # ---CRUD---

  def index
    @articles = Article.where(:is_hidden => false).order("created_at DESC")
  end

  def show
    @article = Article.find(params[:id])
    @user = @article.user
    if @article.is_hidden
      flash[:warning] = "这篇文章在审核中！不可查看！"
      redirect_to root_path
    end
  end

  # ---private---

  private

  def article_params
    params.require(:article).permit(:image, :title, :description, :user_id)
  end

end
