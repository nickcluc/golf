class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.belongs_to :user, null:false
      t.integer :course_id, null:false
      t.date :round_date, null:false
      t.time :tee_time, null:false

      t.timestamps
    end
  end
end
