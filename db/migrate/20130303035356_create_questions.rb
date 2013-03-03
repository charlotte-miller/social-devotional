class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :user_id
      t.integer :source_id
      t.string  :source_type
      t.text    :text
      t.integer :answers_count
      t.integer :blocked_count
      
      t.timestamps
    end
    
    add_index :questions, [:source_id, :source_type]
    # add_index :questions, :answers_count
  end
end
