class CreateTagtweets < ActiveRecord::Migration[5.1]
  def change
    create_table :tagtweets do |t|
      t.references :tweet, foreign_key: true
      t.references :tag, foreign_key: true
      t.timestamps
    end
  end
end
