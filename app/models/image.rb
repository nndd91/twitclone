class Image < ApplicationRecord
  mount_uploader :media_location, TweetmediaUploader
  belongs_to :tweet

  validates :tweet_id, presence: true
end
