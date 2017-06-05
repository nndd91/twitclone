class Message < ApplicationRecord
  belongs_to :from_user_id, class_name: "User"
  belongs_to :to_user_id, class_name: "User"

  def self.check_exist?(user, to_user_id)
    Following.exists?(from_user_id: user, to_user_id: to_user_id)
  end

end
