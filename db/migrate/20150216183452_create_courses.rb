class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name, null:false
      t.string :street_address, null:false
      t.string :city, null:false
      t.string :state, null:false
      t.string :zip_code, null:false
      t.belongs_to :user, null:false
    end
  end
end
