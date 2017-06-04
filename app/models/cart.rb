# == Schema Information
#
# Table name: carts
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

class Cart < ApplicationRecord
  has_many :cart_items
  has_many :products, through: :cart_items, source: :product
  belongs_to :user


  # 加入购物车
  def add_product_to_cart(product,quantity)
    ci = cart_items.build
    ci.product = product
    ci.quantity = quantity
    ci.save
  end


  # 计算总价
  def total_price
    sum = 0
    cart_items.each do |cart_item|
      if cart_item.product.price.present?
        sum += cart_item.quantity * cart_item.product.price
      end
    end
    sum
  end

  def total_price
    sum = 0
    cart_items.each do |cart_item|
      if cart_item.product.price.present?
        if cart_item.product.discount.present?
          sum += cart_item.quantity * cart_item.product.price * cart_item.product.discount / 100
        else
          sum += cart_item.quantity * cart_item.product.price
        end
      end
    end
    sum
  end

  #用户再次登录时，找回用户购物车里的物品
  def merge!(cart)
    cart.cart_items.each do |item|
      add_product_to_cart(item.product, item.quantity)
    end
  end


  #清空购物车
  def clean!
    cart_items.destroy_all
  end


end
