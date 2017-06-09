class AddReplyToIdToReplyModel < ActiveRecord::Migration[5.1]
  def change
     add_column :reply_to_id, :integer
  end
end
