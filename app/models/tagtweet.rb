class Tagtweet < ApplicationRecord
  belongs_to :tweet
  belongs_to :tag

  validates :tweet, presence: true
  validates :tag, presence: true
end
