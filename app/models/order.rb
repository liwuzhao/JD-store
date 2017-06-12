# == Schema Information
#
# Table name: orders
#
#  id               :integer          not null, primary key
#  total            :integer          default(0)
#  user_id          :integer
#  billing_name     :string
#  billing_address  :string
#  shipping_name    :string
#  shipping_address :string
#  phone_numbers    :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  token            :string
#  is_paid          :boolean          default(FALSE)
#  payment_method   :string
#  aasm_state       :string           default("order_placed")
#

class Order < ApplicationRecord
  belongs_to :user
  has_many :product_lists #存储购买明细

  validates :billing_name, presence: true
  validates :phone_numbers, presence: true

  belongs_to :product #下单后对应的商品库存减少

  #乱序订单号

  before_create :generate_token

  def generate_token
    self.token = SecureRandom.uuid
  end

  #付款
  def set_payment_with!(method)
    self.update_columns(payment_method: method )
  end

  def pay!
    self.update_columns(is_paid: true )
  end

  #订单状态

  include AASM

  aasm do
    state :order_placed, initial: true #下单
    state :paid #已付款
    state :activated #已激活

    state :order_cancelled  #申请取消
    state :good_returned    #退货


    event :make_payment, after_commit: :pay! do
      transitions from: :order_placed, to: :paid
    end

    event :activate do
      transitions from: :paid,     to: :activated
    end

    event :return_good do
      transitions from: :activated,      to: :good_returned
    end

    event :cancel_order do
      transitions from: [:order_placed, :paid], to: :order_cancelled
    end
  end

end
