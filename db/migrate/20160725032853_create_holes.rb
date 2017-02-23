class CreateHoles < ActiveRecord::Migration
  def change
    create_table :holes do |t|
      t.integer :number,    null: false
      t.integer :yardage,   null: false
      t.integer :handicap,  null: false
      t.integer :course_id, null: false
    end
  end
end
