class ProductsController < ApplicationController
  before_action :authenticate_user! , only: [:collect, :un_collect]
  before_action :validate_search_key, only: [:search]


  def index
    @products = Product.all

    if params[:c].present?
      @category = params[:c]
      @products = @products.where(:category => @category)
    end
    #排序
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
  end

  def add_to_cart
    @product = Product.find(params[:id])

    if !current_cart.products.include?(@product)
      current_cart.add_product_to_cart(@product)
      flash[:notice] = "你已成功将 #{@product.title} 加入购物车"
    else
     flash[:warning] = "你的购物车内已有此物品"
    end

    redirect_to :back
  end

  def collect
    @product = Product.find(params[:id])

    if !current_user.is_collect_of?(@product)
      current_user.collect!(@product)
      flash[:notice] = "已收藏该商品"
    else
      flash[:warning] = "你已经收藏过该商品了"
    end

    redirect_to product_path(@product)
  end

  def un_collect
    @product = Product.find(params[:id])

    if current_user.is_collect_of?(@product)
      current_user.un_collect!(@product)
      flash[:notice] = "已取消收藏该商品"
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
