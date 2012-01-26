class RemoveUsersRoleIndex < ActiveRecord::Migration
  def up
    remove_index :users, :role_id
  end

  def down
    add_index :users, column: :role_id
  end
end
