class CreateSpeakers < ActiveRecord::Migration
  def change
    create_table :speakers do |t|
      t.string :name
    end

    add_index :speakers, :name

    change_table :sermons do |t|
      t.references :speaker
    end
  end
end
