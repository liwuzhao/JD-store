class ClubCollection < ApplicationRecord
  #会员帖子收藏
  belongs_to :user
  belongs_to :club
end
