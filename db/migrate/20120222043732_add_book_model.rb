class AddBookModel < ActiveRecord::Migration
  def change
    create_table :books do  |t|
      t.string :name, null: false, limit:20
      t.boolean :old_testament, default: false
    end

    add_index :books, :name
    
    change_table :sermons do |t|
      t.remove :passage
      t.references :book
      t.integer :start_chapter
      t.integer :end_chapter
      t.integer :start_verse
      t.integer :end_verse
    end

    add_index :sermons, [ :book_id, :start_chapter, :start_verse ]
  end


end
