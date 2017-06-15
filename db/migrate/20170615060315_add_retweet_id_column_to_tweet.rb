class AddRetweetIdColumnToTweet < ActiveRecord::Migration[5.1]
  def change
    add_column :tweets, :retweet_id, :integer, default: nil
  end
end
