class Message < ApplicationRecord
  belongs_to :from_user, class_name: "User"
  belongs_to :to_user, class_name: "User"

  validates :from_user_id, presence: true
  validates :to_user_id, presence: true
  def self.check_exist?(user, to_user_id)
    Message.exists?(from_user_id: user, to_user_id: to_user_id)
  end

end
