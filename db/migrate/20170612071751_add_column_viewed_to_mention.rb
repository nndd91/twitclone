class AddColumnViewedToMention < ActiveRecord::Migration[5.1]
  def change
    add_column :mentions, :viewed, :boolean, default: false
  end
end
