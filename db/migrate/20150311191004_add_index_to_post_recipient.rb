class AddIndexToPostRecipient < ActiveRecord::Migration
  def change
    add_index :posts, :recipient_id
  end
end
