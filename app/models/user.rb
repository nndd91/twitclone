class User < ActiveRecord::Base
   mount_uploader :avatar, AvatarUploader

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable

  has_many :tweets, dependent: :destroy
  has_many :active_followings, class_name: "Following",
                               foreign_key: "follower_id",
                               dependent: :destroy
  has_many :passive_followings, class_name: "Following",
                               foreign_key: "followed_id",
                               dependent: :destroy
  has_many :following, through: :active_followings, source: :followed
  has_many :followers, through: :passive_followings, source: :follower


  has_many :likes, dependent: :destroy

  has_many :active_messages, class_name: "Message",
                              foreign_key: "from_user_id",
                              dependent: :destroy

  has_many :passive_messages, class_name: "Message",
                              foreign_key: "to_user_id",
                              dependent: :destroy

  has_many :from_user, through: :active_messages, source: :from_user_id
  has_many :to_user, through: :passive_messages, source: :to_user_id

  has_many :mentions, dependent: :destroy
  has_many :mentioned_in_tweets, class_name: "Tweet", foreign_key: "tweet_id", through: :mentions, source: :tweet

  # User Avatar Validation
  validates_integrity_of  :avatar
  validates_processing_of :avatar

  attr_accessor :searchvalue

  private
    def avatar_size_validation
      errors[:avatar] << "should be less than 500KB" if avatar.size > 0.5.megabytes
    end
end
