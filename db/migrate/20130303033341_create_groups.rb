class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.integer :meeting_id
      t.string  :name,             null:false
      t.text    :desription,       null:false
      t.boolean :is_public,        default: true
      t.integer :meets_every_days, default: 7

      t.timestamps
    end
    
    add_index :groups, :meeting_id
  end
end
