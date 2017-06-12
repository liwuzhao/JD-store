class Category < ApplicationRecord
  #产品分类
  has_many :products
end
