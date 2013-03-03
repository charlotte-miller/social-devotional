class CreateGroupMemberships < ActiveRecord::Migration
  def change
    create_table :group_memberships do |t|
      t.integer :group_id
      t.integer :user_id
      t.boolean :public
      t.integer :role_level, default: 0

      t.timestamps
    end
    
     add_index :group_memberships, [:user_id,  :public ]
     add_index :group_memberships, [:group_id, :user_id]
  end
end
