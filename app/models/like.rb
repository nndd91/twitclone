class Like < ApplicationRecord
	belongs_to :user, class_name: "User"
	belongs_to :tweet, class_name: "Tweet"

  validates :tweet_id, uniqueness: { scope: :user_id,
    message: "User can only like tweet once!" }, presence: true
  validates :user_id, presence: true

end
