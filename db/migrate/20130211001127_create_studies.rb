class CreateStudies < ActiveRecord::Migration
  def change
    create_table    :studies do |t|
      t.string      :slug,          null:false
      t.integer     :podcast_id,    null:false
      t.string      :title,         null:false
      t.string      :description
      t.string      :ref_link
      t.attachment  :poster_img
      t.string      :poster_img_original_url
      t.string      :poster_img_fingerprint
      t.text        :keywords,      null:false
      t.integer     :lessons_count, default: 0
                    
      t.datetime    :last_published_at
      t.timestamps
    end
    
    add_index :studies, :slug, unique: true
    add_index :studies, [:podcast_id, :last_published_at]
    add_index :studies, :last_published_at
  end
end
