class AddUserToTee < ActiveRecord::Migration
  def change
    add_column :tees, :user_id, :integer
  end
end
