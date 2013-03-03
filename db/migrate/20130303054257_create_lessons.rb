class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.integer  :series_id,    null: false
      t.integer  :position,     default: 0
      t.string   :title,        null: false
      t.text     :description
      t.string   :backlink
      t.string   :video_url
      t.string   :audio_url

      t.timestamps
    end
    
    add_index :lessons, [:series_id, :position]
  end
end