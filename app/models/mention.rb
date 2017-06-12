class Mention < ApplicationRecord
  belongs_to :tweet
  belongs_to :user

  validates :tweet, presence: true
  validates :user, presence: true
end
