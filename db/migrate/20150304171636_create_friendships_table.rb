class CreateFriendshipsTable < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.integer :user_id, null: false
      t.integer :friend_id, null: false
      t.boolean :accepted, null: false, default: false
    end
  end
end
