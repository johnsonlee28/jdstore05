class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def add_to_cart
    @product = Product.find(params[:id])
    if !current_cart.products.include?(@product)
      current_cart.add_product_to_cart(@product)
      redirect_to :back, notice:"Added to cart"
    else
      redirect_to :back, alert:"购物车已存在#{@product.title}商品"
    end

  end

end
