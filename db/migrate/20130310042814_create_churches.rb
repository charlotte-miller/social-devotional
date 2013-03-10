class CreateChurches < ActiveRecord::Migration
  def change
    create_table :churches do |t|
      t.string :name,     null:false,  limit:100
      t.string :homepage, null:false,  limit:100

      t.timestamps
    end
  end
end
