class EnhanceBookIndex < ActiveRecord::Migration
  def up
    remove_index :sermons, [ :book_id, :start_chapter, :start_verse ]
    add_index :sermons, [ :book_id, :start_chapter, :start_verse, 
      :end_chapter, :end_verse ], name: "index_sermons_on_passage"
  end

  def down
    remove_index :sermons, "index_sermons_on_passage"
    add_index :sermons, [ :book_id, :start_chapter, :start_verse ]
  end
end
