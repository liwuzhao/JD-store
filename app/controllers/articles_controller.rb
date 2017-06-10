class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy, :join ,:quit]


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

  # ---article_collection 收藏文章---

  def join
    @article = Article.find(params[:id])

    if !current_user.is_article_member_of?(@article)
      current_user.join_article_collection!(@article)
    end
      redirect_to article_path(@article)
  end

  def quit
    @article = Article.find(params[:id])

    if current_user.is_article_member_of?(@article)
      current_user.quit_article_collection!(@article)
    end
      redirect_to article_path(@article)
  end



  # ---private---

  private

  def article_params
    params.require(:article).permit(:image, :title, :description, :user_id)
  end

end
