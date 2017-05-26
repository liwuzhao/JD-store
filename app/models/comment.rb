# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  content    :text
#  user_id    :integer
#  product_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Comment < ApplicationRecord
  belongs_to :product
  belongs_to :user
  validates :content, presence: true
end
