class AddServiceToSermons < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name
    end

    add_index :services, :name

    change_table :sermons do |t|
      t.references :service
    end
  end
end
