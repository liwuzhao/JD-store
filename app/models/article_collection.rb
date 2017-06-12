class ArticleCollection < ApplicationRecord
  #文章点赞
  belongs_to :user
  belongs_to :article
end
