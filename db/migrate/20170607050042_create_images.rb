class CreateImages < ActiveRecord::Migration[5.1]
  def change
    create_table :images do |t|
      t.integer :tweet_id
      t.string :media_location

      t.timestamps
    end
  end
end
