# == Schema Information
#
# Table name: article_collections
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  article_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ArticleCollection < ApplicationRecord
  #文章点赞
  belongs_to :user
  belongs_to :article
end
