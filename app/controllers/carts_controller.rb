class CartsController < ApplicationController
  before_action :authenticate_user! , only: [:checkout]

  def clean
    current_cart.clean!
    flash[:warning] = "已清空购物车"
    redirect_to carts_path
  end

  def checkout
    if current_cart.cart_items.present?
      @order = Order.new
    else
      redirect_to carts_path
      flash[:warning] = "购物车是空的！"
    end
  end

  def add_quantity
    @cart_item = current_cart.cart_items.find_by_product_id(params[:id])
    if @cart_item.quantity < @cart_item.product.quantity
      @cart_item.quantity += 1
      @cart_item.save
      #  redirect_to carts_path
    elsif @cart_item.quantity == @cart_item.product.quantity
      #  redirect_to carts_path, alert: "库存不足！"
    end
  end

  def remove_quantity
    @cart_item = current_cart.cart_items.find_by_product_id(params[:id])
    if @cart_item.quantity > 0
      @cart_item.quantity -= 1
      @cart_item.save
      render "add_quantity"
    elsif @cart_item.quantity == 0
      render "add_quantity"
    end
  end

end
