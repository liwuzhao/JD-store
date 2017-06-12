class CommentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @product = Product.find(params[:product_id])
    @comment = Comment.new
  end

  def create
      @product = Product.find(params[:product_id])
      @comment = Comment.new(comment_params)
      @comment.product = @product
      @comment.user = current_user
      if @comment.save
        redirect_to :back
      else
        render :new
      end

  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
