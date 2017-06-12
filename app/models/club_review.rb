class ClubReview < ApplicationRecord
  #会员分享帖子评论
  belongs_to :user
  belongs_to :club

end
