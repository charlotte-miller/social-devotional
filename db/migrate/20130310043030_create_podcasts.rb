class CreatePodcasts < ActiveRecord::Migration
  def change
    create_table :podcasts do |t|
      t.integer  :church_id,     null:false
      t.string   :title,          limit:100
      t.string   :url,            null:false
      t.datetime :last_checked
      t.datetime :last_updated

      t.timestamps
    end
    
    add_index :podcasts, :church_id
  end
end
