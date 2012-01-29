class BooleanDefaults < ActiveRecord::Migration
  def up
    change_column :roles, :superuser, :boolean, :default => false
    change_column :roles, :manage_roles, :boolean, :default => false
    change_column :roles, :add_sermons, :boolean, :default => false
    change_column :roles, :edit_sermons, :boolean, :default => false
    change_column :roles, :delete_sermons, :boolean, :default => false
    change_column :roles, :add_edit_users, :boolean, :default => false
    change_column :roles, :delete_users, :boolean, :default => false
  end

  def down
    change_column :roles, :superuser, :boolean, :default => nil
    change_column :roles, :manage_roles, :boolean, :default => nil
    change_column :roles, :add_sermons, :boolean, :default => nil
    change_column :roles, :edit_sermons, :boolean, :default => nil
    change_column :roles, :delete_sermons, :boolean, :default => nil
    change_column :roles, :add_edit_users, :boolean, :default => nil
    change_column :roles, :delete_users, :boolean, :default => nil
  end
end
