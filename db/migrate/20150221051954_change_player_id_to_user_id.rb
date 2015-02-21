class ChangePlayerIdToUserId < ActiveRecord::Migration
  def change
    rename_column :player_rounds, :player_id, :user_id
  end
end
