class ChangeRecipientColumnName < ActiveRecord::Migration
  def change
    rename_column :posts, :recipient_user_id, :recipient_id
  end
end
