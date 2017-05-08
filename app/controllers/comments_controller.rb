class CommentsController < ApplicationController

  before_action :authenticate_user!


  def create
    @product = Product.find(params[:product_id])
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.product = @product
    if @comment.save
      redirect_to :back
    else
      render :new
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:description)
  end
end
