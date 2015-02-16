class AddHandicapToUsers < ActiveRecord::Migration
  def change
    add_column :users, :handicap, :integer
  end
end
