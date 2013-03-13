class CreateStars < ActiveRecord::Migration
  def change
    create_table :stars do |t|
      t.integer :user_id,       null:false
      t.integer :source_id,     null:false
      t.string  :source_type,   null:false,   limit:50

      t.timestamps
    end
    
    add_index :stars, :user_id
    add_index :stars, [:source_id, :source_type]
  end
end
