class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.references :question
      t.references :author
      t.text    :text
      t.integer :blocked_count, default:0
      t.integer :stared_count,  default:0

      t.timestamps
    end
    add_index :answers, :question_id
    add_index :answers, :author_id
  end
end
