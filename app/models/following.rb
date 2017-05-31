class Following < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

  def self.check_exist?(user, following_id)
    Following.exists?(follower_id: user, followed_id: following_id)
  end

  def self.follow_user(follower_id, following_id)
    
  end

  def self.unfollow_user(follower_id, following_id)
  end

end
