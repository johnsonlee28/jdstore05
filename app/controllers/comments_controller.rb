class CommentsController < ApplicationController

  before_action :authenticate_user!

  def create
    @comment = Comment.new
    @comment.user = current_user
    if @comment.update(comment_params)
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
