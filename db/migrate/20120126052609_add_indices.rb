class AddIndices < ActiveRecord::Migration
  def change
    add_index :sermons, :date
    add_index :sermons_tags, :sermon_id
    add_index :sermons_tags, :tag_id
    add_index :users, :username
  end
end
