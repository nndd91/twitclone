class Mention < ApplicationRecord
  belongs_to :tweet
  belongs_to :user

  has_many :authors, through: :tweet, source: :user

  validates :tweet, presence: true
  validates :user, presence: true
end
