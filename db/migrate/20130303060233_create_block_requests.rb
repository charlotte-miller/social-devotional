class CreateBlockRequests < ActiveRecord::Migration
  def change
    create_table :block_requests do |t|
      t.integer :admin_id
      t.integer :user_id
      t.integer :source_id
      t.string  :source_type

      t.timestamps
    end
    
    add_index :block_requests, :user_id
    add_index :block_requests, [:source_id, :source_type]
  end
end
