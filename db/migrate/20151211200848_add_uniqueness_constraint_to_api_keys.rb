class AddUniquenessConstraintToApiKeys < ActiveRecord::Migration
  def change
    add_index :api_keys, [:access_token], unique: true
  end
end
