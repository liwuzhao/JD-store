# == Schema Information
#
# Table name: club_votes
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  club_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ClubVote < ApplicationRecord
  #会员分享帖子点赞
  belongs_to :user
  belongs_to :club
end
