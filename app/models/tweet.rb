class Tweet < ApplicationRecord

  attr_accessor :media_location, :media_location_cache, :remove_media_location

  belongs_to :user
  validates :body, length: { maximum: 140 }, presence: true
  has_many :likes, dependent: :destroy
  has_many :images, dependent: :destroy
  has_many :mentions, dependent: :destroy
  has_many :replys, dependent: :destroy

  has_one :main_tweet, :class_name => "Tweet", :foreign_key => "retweet_id"
  has_many :retweets, :class_name => "Tweet", :foreign_key => "retweet_id"

  def self.get_tweets(following_ids, current_user_id)
    Tweet.where("user_id IN (?) OR user_id = ?", following_ids, current_user_id)
  end

end
