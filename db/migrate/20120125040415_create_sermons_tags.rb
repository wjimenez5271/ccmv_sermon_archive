class CreateSermonsTags < ActiveRecord::Migration
  def change
    create_table :sermons_tags do |t|
      t.references :sermon
      t.references :tag
    end

    create_table :sermons do |t|
      t.string :title
      t.date :date
      t.string :passage
      t.string :summary

      t.timestamps
    end

    create_table :tags do |t|
      t.string :name
    end
  end
end
