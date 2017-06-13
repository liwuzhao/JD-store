# == Schema Information
#
# Table name: club_collections
#
#  id         :integer          not null, primary key
#  club_id    :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ClubCollection < ApplicationRecord
  #会员帖子收藏
  belongs_to :user
  belongs_to :club
end
