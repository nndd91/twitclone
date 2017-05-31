class Tweet < ApplicationRecord
  belongs_to :user
  validates :body, length: { maximum: 140 }
end
