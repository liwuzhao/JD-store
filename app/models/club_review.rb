# == Schema Information
#
# Table name: club_reviews
#
#  id         :integer          not null, primary key
#  comment    :string
#  club_id    :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ClubReview < ApplicationRecord
  #会员分享帖子评论
  belongs_to :user
  belongs_to :club

end
