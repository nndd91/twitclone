class AddColumnThemeInUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :theme, :integer, default: 'default'
  end
end
