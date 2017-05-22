# == Schema Information
#
# Table name: carts
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Cart < ApplicationRecord
  has_many :cart_items
  has_many :products, through: :cart_items, source: :product
  belongs_to :user


  # 加入购物车
  def add_product_to_cart(product)
    ci = cart_items.build
    ci.product = product
    ci.quantity = 1
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

  def add(product, quantity)
    if products.include?(product)
      cart_item = cart_items.find_by_product_id(product.id)
    else
      cart_item = cart_items.build
    end
    cart_item.product = product
    cart_item.quantity += quantity
    product.quantity -= quantity
    product.save
    cart_item.save
  end

  def merge!(cart)
    cart.cart_items.each do |item|
      add(item.product, item.quantity)
    end
  end


  #清空购物车
  def clean!
    cart_items.destroy_all
  end


end
