class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string  :state,            null:false,  limit:50
      t.string  :name,             null:false
      t.text    :desription,       null:false
      t.boolean :is_public,        default: true
      t.integer :meets_every_days, default: 7

      t.timestamps
    end
    
    add_index :groups, [:state, :is_public]
  end
end
