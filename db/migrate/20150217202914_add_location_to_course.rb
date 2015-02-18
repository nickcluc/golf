class AddLocationToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :latitude, :float
    add_column :courses, :longitude, :float
  end
end
