class CreatePlayerRounds < ActiveRecord::Migration
  def change
    create_table :player_rounds do |t|
      t.integer :player_id, null:false
      t.integer :round_id, null:false
      t.integer :score, null:false
      t.integer :hole_count, null:false
    end
  end
end
