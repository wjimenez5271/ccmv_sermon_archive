class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :username
      t.string :password_digest
      t.references :role

      t.timestamps
    end
    add_index :users, :role_id
  end
end
