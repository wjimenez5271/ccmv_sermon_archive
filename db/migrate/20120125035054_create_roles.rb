class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name
      t.boolean :superuser
      t.boolean :manage_roles
      t.boolean :add_sermons
      t.boolean :edit_sermons
      t.boolean :delete_sermons
      t.boolean :add_edit_users
      t.boolean :delete_users

      t.timestamps
    end
  end
end
