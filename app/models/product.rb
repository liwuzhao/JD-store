# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  price       :integer
#  quantity    :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  image       :string
#  position    :integer
#  is_public   :boolean          default(TRUE)
#  category_id :integer
#  discount    :integer
#

class Product < ApplicationRecord

  belongs_to :category #商品分类

  #购物车的三方关系
  has_many :cart_items
  has_many :cart, through: :cart_items, :dependent => :destroy

  #评论
  has_many :comments

  #用户收藏商品的三方关系
  has_many :favours
  has_many :collectors, through: :favours, source: :user

  #上传商品图
  mount_uploader :image, ImageUploader

  #商品顺序
  acts_as_list

  scope :published, -> { where(is_public: true) }

  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :quantity, presence: true
  validates_numericality_of :discount, :greater_than => 0, :less_than => 100, :allow_blank => true

  #商品上架/下架
  def publish!
    self.is_public = true
    self.save
  end

  def hide!
    self.is_public = false
    self.save
  end

end
