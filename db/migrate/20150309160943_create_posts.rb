class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :user_id, null: false
      t.integer :recipient_user_id, null: false
      t.text :body, null: false
    end
  end
end
