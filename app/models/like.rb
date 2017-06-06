class Like < ApplicationRecord
	belongs_to :user, class_name: "User"
	belongs_to :tweet, class_name: "Tweet"

  def self.if_liked?(tweet_id, user_id)
    Like.find_by(user_id: user_id, tweet_id: tweet_id)
  end

end
