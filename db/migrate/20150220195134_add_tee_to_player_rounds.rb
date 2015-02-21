class AddTeeToPlayerRounds < ActiveRecord::Migration
  def change
    add_column :player_rounds, :tee_id, :integer, null:false
  end
end
