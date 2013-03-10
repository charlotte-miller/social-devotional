class CreateBlockRequests < ActiveRecord::Migration
  def change
    create_table :block_requests do |t|
      t.integer :admin_user_id
      t.integer :user_id,       null:false
      t.integer :source_id,     null:false
      t.string  :source_type,   null:false

      t.timestamps
    end
    
    add_index :block_requests, :user_id
    add_index :block_requests, [:source_id, :source_type]
  end
end
