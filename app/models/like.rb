class Like < ApplicationRecord
	belongs_to :user_id, class_name: "User"
	belongs_to :tweet_id, class_name: "Tweet"

end
