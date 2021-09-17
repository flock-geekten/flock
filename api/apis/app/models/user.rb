class User < ApplicationRecord 
	validates :uid, presence: true
	validates :name, presence: true
	validates :email, presence: true
  has_many :posts
  has_many :comments
  has_many :user_hangout_funs
  has_many :user_hangout_results
  has_many :plans
  has_many :participations

  # いいね機能関係
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post

  # フォロー機能関係
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :follower
  # 被フォロー関係を通じて参照→followed_idをフォローしている人

  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # 【class_name: "Relationship"】は省略可能
  has_many :followings, through: :relationships, source: :followed
  # 与フォロー関係を通じて参照→follower_idをフォローしている人

  # フォロー
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end
  
  # フォローをはずす
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  # フォローをしているかどうか
  def following?(user)
    followings.include?(user)
  end
end
