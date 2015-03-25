class AddCompletedToPlayerRound < ActiveRecord::Migration
  def change
    add_column :player_rounds, :completed, :boolean, default: false
  end
end
