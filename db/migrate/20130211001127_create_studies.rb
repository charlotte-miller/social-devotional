class CreateStudies < ActiveRecord::Migration
  def change
    create_table   :studies do |t|
      t.string     :slug,          null:false
      t.integer    :podcast_id,    null:false
      t.string     :title,         null:false
      t.string     :description
      t.string     :ref_link
      t.string     :video_url  #should be media url
      t.attachment :poster_img
      # t.attachment :media
      t.integer    :lessons_count, default: 0

      t.timestamps
    end
    
    add_index :studies, :slug, unique: true
    add_index :studies, :podcast_id
  end
end
