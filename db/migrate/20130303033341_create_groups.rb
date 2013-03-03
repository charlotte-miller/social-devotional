class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.integer :meeting_id
      t.string  :name
      t.text    :desription
      t.boolean :public
      t.integer :meets_every_days, default: 7

      t.timestamps
    end
    
    add_index :groups, :meeting_id
  end
end
