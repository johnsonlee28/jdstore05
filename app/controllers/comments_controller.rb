class CommentsController < ApplicationController

  before_action :authenticate_user!, :only => [:new, :create]

  def new
    @product = Product.find(params[:product_id])
    @comment = Comment.new
    @graphic = @comment.graphics.build
  end


  def create
    @product = Product.find(params[:product_id])
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.product = @product
    if @comment.save
      if params[:graphics] != nil
        params[:graphics]['avatar'].each do |a|
          @graphic = @comment.graphics.create(:avatar => a)
        end
      end
      redirect_to product_path(@product)
    else
      render :new
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:description, :image)
  end
end
