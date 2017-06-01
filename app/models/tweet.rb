class Tweet < ApplicationRecord
  belongs_to :user
  validates :body, length: { maximum: 140 }, presence: true

  def self.get_tweets(following_ids, current_user_id)
    Tweet.where("user_id IN (?) OR user_id = ?", following_ids, current_user_id)
  end

end
