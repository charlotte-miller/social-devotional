class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.integer :series_id
      t.string  :name
      t.text    :desription
      t.boolean :public

      t.timestamps
    end
    
    add_index :groups, :series_id
  end
end
