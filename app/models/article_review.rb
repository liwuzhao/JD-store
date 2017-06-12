class ArticleReview < ApplicationRecord
  #文章评论
  belongs_to :user
  belongs_to :article
end
