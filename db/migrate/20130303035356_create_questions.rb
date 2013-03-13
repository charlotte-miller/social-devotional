class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :user_id,        null:false
      t.integer :source_id,      null:false
      t.string  :source_type,    null:false
      t.text    :text,           null:false
      t.integer :answers_count,  default: 0
      t.integer :blocked_count,  default: 0
      t.integer :stared_count,   default: 0
      
      t.timestamps
    end
    
    add_index :questions, [:source_id, :source_type]
    add_index :questions, :stared_count
    
    # add_index :questions, :answers_count
  end
end
