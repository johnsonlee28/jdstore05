class ProductsController < ApplicationController
  before_action :validate_search_key, only: [:search]
  def index
    if params[:category].present?
      @category_id = Category.find_by(name: params[:category]).id
      @products = Product.where(category_id: @category_id)
    else
      @products = case params[:order]
      when 'by_price'
          Product.all.order("price DESC")
      when 'by_fans'
        Product.all.sort_by {|product| product.likes.count}.reverse
      else
        Product.all.order('created_at DESC')
      end
    end
  end

  def show
    @product = Product.find(params[:id])
    @photos = @product.photos.all
    @prints = @product.prints.all
    @comment = Comment.new
    @comments = @product.comments

    if @comments.blank?
       @avg_comment = 0
     else
       @avg_comment = @comments.average(:rating).round(2)
     end
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
