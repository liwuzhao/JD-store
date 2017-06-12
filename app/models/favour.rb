# == Schema Information
#
# Table name: favours
#
#  id         :integer          not null, primary key
#  product_id :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Favour < ApplicationRecord
  #用户收藏商品的三方关系
  belongs_to :user
  belongs_to :product
end
