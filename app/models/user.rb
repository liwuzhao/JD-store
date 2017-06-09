# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  is_admin               :boolean          default(FALSE)
#  nickname               :string
#  name                   :string
#  address                :string
#  numbers                :string
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :orders
  has_many :comments

  has_many :favours
  has_many :collections, through: :favours, source: :product

  has_many :clubs
  has_many :club_reviews, dependent: :destroy

  has_many :club_collections #收藏社群
  has_many :participated_clubs, through: :club_collections, source: :club

  has_one :cart

  validates :nickname, presence: true
  validates_length_of :numbers, maximum: 11

  def admin?
    is_admin
  end

# 收藏商品
  def is_collect_of?(product)
    collections.include?(product)
  end

  def collect!(product)
    collections << product
  end

  def un_collect!(product)
    collections.delete(product)
  end

# 收藏社群
  def is_club_member_of?(club)
    participated_clubs.include?(club)
  end

  def join_club_collection!(club)
    participated_clubs << club
  end

  def quit_club_collection!(club)
    participated_clubs.delete(club)
  end

end
