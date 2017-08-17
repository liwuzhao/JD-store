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

  belongs_to :category ,:optional => true#商品分类

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

  scope :published, -> { where("is_public = ?", true) }

  validates_presence_of :title, :description, :price, :quantity, :friendly_id
  validates_uniqueness_of :friendly_id
  validates_format_of :friendly_id, :with => /\A[a-z0-9\-]+\z/

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

  #ID
  def to_param
    self.friendly_id
  end

  before_validation :generate_friendly_id, :on => :create

  protected

  def generate_friendly_id
    self.friendly_id ||= SecureRandom.uuid
  end

end
