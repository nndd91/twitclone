class Tag < ApplicationRecord
    has_many :tagtweets, dependent: :destroy
    has_many :tweets, through: :tagtweets

end
