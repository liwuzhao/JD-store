class ClubVote < ApplicationRecord
  #会员分享帖子点赞
  belongs_to :user
  belongs_to :club
end
