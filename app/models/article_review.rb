# == Schema Information
#
# Table name: article_reviews
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  article_id :integer
#  comment    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ArticleReview < ApplicationRecord
  #文章评论
  belongs_to :user
  belongs_to :article
end
