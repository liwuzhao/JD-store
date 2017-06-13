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
end
