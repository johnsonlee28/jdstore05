class Admin::ProductsController < ApplicationController
  layout 'admin'

  before_action :authenticate_user!
  before_action :require_admin



  def index
    @products = Product.includes(:photos).all
  end

  def new
    @product = Product.new
    @categories = Category.all.map{ |c| [c.name, c.id]}
    @photo = @product.photos.build #for multi-pics
    @print = @product.prints.build
  end

  def create
    @product = Product.new(product_params)
    @product.category_id = params[:category_id]
    if @product.update(product_params)
      if params[:photos] != nil
        params[:photos]['avatar'].each do |a|
          @photo = @product.photos.create(:avatar => a )
        end
      end

      if params[:prints] != nil
        params[:prints]['avatar'].each do |a|
          @print = @product.prints.create(:avatar => a)
        end
      end
      redirect_to admin_products_path
    else
      render :new
    end
  end

  def show
    @product = Product.find(params[:id])
    @photos = @product.photos.all
  end

  def edit
    @product = Product.find(params[:id])
    @categories = Category.all.map{ |c| [c.name, c.id]}
  end

  def update
    @product = Product.find(params[:id])
    @product.category_id = params[:category_id]

    if params[:photos] != nil
      @product.photos.destroy_all #need to destory old pics first

      params[:photos]['avatar'].each do |a|
        @picture = @product.photos.create(:avatar => a)
      end
    end

    if @product.update(product_params)
      redirect_to admin_products_path
    else
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to admin_products_path
  end



  private

  def product_params
    params.require(:product).permit(:title, :description, :quantity, :price, :image, :category_id, :detail, :rating)
  end

end
