class ProductsController < ApplicationController
  before_action :authenticate_user! , only: [:collect, :un_collect]
  before_action :validate_search_key, only: [:search]


  def index
    if params[:category].blank?
      @products = Product.published
    else
      @category_id = Category.find_by(name: params[:category]).id
      @products = Product.published.where(:category_id => @category_id)
    end

    @products = case params[:order]
        when 'by_lower_price'
          @products.order('price ASC')
        when 'by_upper_price'
          @products.order('price DESC')
        else
          @products.order("position ASC")
        end
  end

  def show
    @product = Product.find(params[:id])
    @comment = Comment.new
  end

  def add_to_cart
    @product = Product.find(params[:id])
    @quantity = params[:quantity].to_i

    if current_cart.products.include?(@product)
      flash[:warning] = "你的购物车内已有此物品"
    elsif @quantity <= @product.quantity # 如果输入的数量小于库存
      current_cart.add_product_to_cart(@product, @quantity)
      flash[:notice] = "您选择的商品已加入购物车"
    else
      flash[:warning] = "您选择的商品数量超过库存"
    end

    redirect_to product_path(@product)
  end

  def pay_now
    @product = Product.find(params[:id])
    @quantity = 1

    if !current_cart.products.include?(@product)
      current_cart.add_product_to_cart(@product, @quantity)
      redirect_to carts_path
    else
      flash[:warning] = "你的购物车内已有此物品"
      redirect_to carts_path
    end

  end

  def collect
    @product = Product.find(params[:id])

    if !current_user.is_collect_of?(@product)
      current_user.collect!(@product)
    else
      flash[:warning] = "你已经收藏过该商品了"
    end

    redirect_to product_path(@product)
  end

  def un_collect
    @product = Product.find(params[:id])

    if current_user.is_collect_of?(@product)
      current_user.un_collect!(@product)
    else
      flash[:warning] = "你还没有收藏该商品"
    end

    redirect_to product_path(@product)
  end

  def search
    if @query_string.present?
      search_result = Product.ransack(@search_criteria).result(:distinct => true)
      @products = search_result.paginate(:page => params[:page], :per_page => 5 )
    end
  end


  protected

  def validate_search_key
    @query_string = params[:q].gsub(/\\|\'|\/|\?/, "") if params[:q].present?
    @search_criteria = search_criteria(@query_string)
  end


  def search_criteria(query_string)
    { :title_or_description_cont => query_string }
  end

end
