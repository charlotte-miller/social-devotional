class CreateSeries < ActiveRecord::Migration
  def change
    create_table :series do |t|
      t.string :slug,         null:false
      t.string :title,        null:false
      t.string :description
      t.string :ref_link
      t.string :video_url

      t.timestamps
    end
    
    add_index :series, :slug, unique: true
  end
end
