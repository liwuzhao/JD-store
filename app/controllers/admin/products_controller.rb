class Admin::ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_required
  before_action :find_product , only: [:show, :hide, :publish, :edit, :update, :destroy, :move_up, :move_down, :published ]
  layout "admin"

  def index
    @products = Product.all.order("position ASC")
  end


  def show
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    @product.category_id = params[:category_id]

    if @product.save
      redirect_to admin_products_path
      flash[:notice] = "创建商品成功"
    else
      render :new
    end
  end

  def edit
  end

  def update
    @product.category_id = params[:category_id]

    if @product.update(product_params)
      redirect_to admin_products_path
      flash[:notice] = "更新商品信息成功"
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to admin_products_path, alert:'已删除商品'
  end

  def move_up
    @product.move_higher
    redirect_to :back
  end

  def move_down
    @product.move_lower
    redirect_to :back
  end

  def hide
    @product.hide!
    redirect_to :back
  end

  def publish
    @product.publish!
    redirect_to :back
  end

  private

  def product_params
    params.require(:product).permit(:description,:title,:quantity,:price,:image,:is_public,:discount,:friendly_id,:category_id)
  end

end
