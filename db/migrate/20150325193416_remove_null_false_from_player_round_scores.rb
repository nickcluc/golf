class RemoveNullFalseFromPlayerRoundScores < ActiveRecord::Migration
  def change
    change_column_null :player_rounds, :score, true
    change_column_null :player_rounds, :tee_id, true
    change_column_null :player_rounds, :hole_count, true
  end
end
