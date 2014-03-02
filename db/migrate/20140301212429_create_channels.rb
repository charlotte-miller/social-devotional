class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|
      t.string :type,           null:false
      t.integer :church_id,     null:false
      t.string :title,          null:false, limit:100
      t.text :build_options
      t.datetime :last_checked_at
      t.datetime :last_updated_at

      t.timestamps
    end
    
    add_index :channels, :type
    add_index :channels, [:church_id, :type]
    add_index :channels, :last_checked_at
  end
end
