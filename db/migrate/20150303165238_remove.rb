class Remove < ActiveRecord::Migration
  def change
    remove_column :tees, :name
  end
end
