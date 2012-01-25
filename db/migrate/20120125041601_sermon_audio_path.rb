class SermonAudioPath < ActiveRecord::Migration
  def change
    change_table :sermons do |t|
      t.string :audio_path
    end
  end
end
