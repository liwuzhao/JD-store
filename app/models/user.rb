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

  #用户创建的帖子与评论
  has_many :clubs
  has_many :club_reviews, dependent: :destroy

  #用户拥有一个购物车
  has_one :cart

  #用户发表的文章与评论
  has_many :articles
  has_many :article_reviews

  validates :nickname, presence: true
  validates_length_of :numbers, maximum: 11

  mount_uploader :avatar, ImageUploader #头像

  #判断是否为admin
  def admin?
    is_admin
  end

  # 收藏商品
  has_many :favours
  has_many :collections, through: :favours, source: :product

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
  has_many :club_collections
  has_many :participated_clubs, through: :club_collections, source: :club

  def is_club_member_of?(club)
    participated_clubs.include?(club)
  end

  def join_club_collection!(club)
    participated_clubs << club
  end

  def quit_club_collection!(club)
    participated_clubs.delete(club)
  end

  # 会员分享帖子点赞

  has_many :club_votes
  has_many :participated_club_votes, through: :club_votes, source: :club

  def is_club_vote_member_of?(club)
    participated_club_votes.include?(club)
  end

  def join_club_vote!(club)
    participated_club_votes << club
  end



  # 收藏文章

  has_many :article_collections                               #收藏商品关系
  has_many :participated_articles, through: :article_collections, source: :article

  def is_article_member_of?(article)
    participated_articles.include?(article)
  end

  def join_article_collection!(article)
    participated_articles << article
  end

  def quit_article_collection!(article)
    participated_articles.delete(article)
  end


end
