class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable

  has_many :active_followings, class_name: "Following",
                               foreign_key: "follower_id",
                               dependent: :destroy
  has_many :passive_followings, class_name: "Following",
                               foreign_key: "followed_id",
                               dependent: :destroy
  has_many :following, through: :active_followings, source: :followed
  has_many :followers, through: :passive_followings, source: :follower

  def following?(user)
    Following.exists?(follower_id: user, followed_id: id)
  end

  def follow_user(follower_id)
    Following.create(follower_id: follower_id, followed_id: id)
  end

  def unfollow_user(follower_id)
    Following.find_by(follower_id: follower_id, followed_id: id).destroy
  end

end
