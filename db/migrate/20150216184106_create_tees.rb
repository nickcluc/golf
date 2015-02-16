class CreateTees < ActiveRecord::Migration
  def change
    create_table :tees do |t|
      t.string :name
      t.string :color, null:false
      t.integer :slope, null:false
      t.integer :rating, null:false
      t.integer :yardage, null:false
      t.belongs_to :course, null:false
    end
  end
end
