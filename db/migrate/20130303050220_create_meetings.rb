class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.integer  :group_id,   null:false
      t.integer  :lesson_id,  null:false
      t.datetime :date_of

      t.timestamps
    end
    
    add_index :meetings, [:group_id, :date_of]
    add_index :meetings, :lesson_id 
  end
end
