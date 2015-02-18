class AddPhoneToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :phone, :string
  end
end
