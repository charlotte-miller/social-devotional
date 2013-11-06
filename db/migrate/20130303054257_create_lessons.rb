class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.integer       :study_id,        null: false
      t.integer       :position,        default: 0
      t.string        :title,           null: false
      t.text          :description
      t.string        :backlink
      t.attachment    :poster_img
      t.attachment    :video
      t.string        :video_original_url
      t.attachment    :audio
      t.string        :audio_original_url
      t.boolean       :machine_sorted,  default: false
      t.integer       :duration #in seconds
      t.datetime      :published_at
      t.timestamps
    end
    
    add_index :lessons, [:study_id, :position]
    add_index :lessons, :backlink
  end
end
