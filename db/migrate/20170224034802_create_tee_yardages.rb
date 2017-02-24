class CreateTeeYardages < ActiveRecord::Migration
  def change
    create_table :tee_yardages do |t|
      t.integer :tee_id, null: false
      t.integer :hole_id, null: false
      t.integer :yardage, null: false
    end
  end
end
