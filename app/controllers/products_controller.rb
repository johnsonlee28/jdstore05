class ProductsController < ApplicationController
  before_action :validate_search_key, only: [:search]
  def index
    if params[:category].blank?
      @products = Product.all
    else
      @category_id = Category.find_by(name: params[:category]).id
      @products = Product.where(:category_id => @category_id)
    end
  end

  def show
    @product = Product.find(params[:id])
    @photos = @product.photos.all
    @comment = Comment.new
    @comments = @product.comments
  end

  def add_to_cart
    @product = Product.find(params[:id])
    if !current_cart.products.include?(@product)
      current_cart.add_product_to_cart(@product)
      redirect_to :back, notice:"#{@product.title} 已加入购物车"
    else
      redirect_to :back, alert:"购物车已存在#{@product.title}商品"
    end
  end

  def buynow
    @product = Product.find(params[:id])
    if !current_cart.products.include?(@product)
      current_cart.add_product_to_cart(@product)
      redirect_to carts_path
    else
      redirect_to :back, alert:"购物车已存在#{@product.title}商品"
    end
  end



  def search
    if @query_string.present?
      search_result = Product.ransack(@search_criteria).result(distinct: true)
      @products = search_result.paginate(page: params[:page], per_page: 5)
    end
  end

  def like
    @product = Product.find(params[:id])
    unless @product.find_like(current_user)
      Like.create( :user => current_user, :product => @product )
    end
    render "like"
  end

  def unlike
    @product = Product.find(params[:id])
    like = @product.find_like(current_user)
    like.destroy

    render "like"
  end

  def collect
    @product = Product.find(params[:id])
    unless @product.find_collect(current_user)
      Collect.create( :user => current_user, :product => @product)
    end
    render "collect"
  end

  def uncollect
    @product = Product.find(params[:id])
    collect = @product.find_collect(current_user)
    collect.destroy

    render "collect"
  end

  protected

  def validate_search_key
    @query_string = params[:q].gsub(/\\|\'|\/|\?/, "") if params[:q].present?
    @search_criteria = search_criteria(@query_string)
  end

  def search_criteria(query_string)
    { :title_cont => query_string }
  end

end
