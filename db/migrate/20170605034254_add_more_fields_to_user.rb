class AddMoreFieldsToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :user, :first_name, :string
    add_column :user, :last_name, :string
    add_column :user, :username, :string
    add_column :user, :avatar, :string
    add_column :user, :age, :integer
  end
end
