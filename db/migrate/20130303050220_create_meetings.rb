class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.integer  :group_id,   null:false
      t.integer  :lesson_id,  null:false
      t.integer  :position,   null:false,  default:0
      t.string   :state,      null:false,  limit: 50
      t.datetime :date_of

      t.timestamps
    end
    
    add_index :meetings, [:group_id, :position]
    add_index :meetings, [:group_id, :state]
    add_index :meetings, :lesson_id 
  end
end
