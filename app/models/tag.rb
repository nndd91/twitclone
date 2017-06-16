class Tag < ApplicationRecord
    has_many :tagtweets, dependent: :destroy
  
end
