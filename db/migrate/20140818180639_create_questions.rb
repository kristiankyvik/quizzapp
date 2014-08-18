class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :title
      t.string :song
      t.text :explanation
      t.integer :quiz_id
      t.timestamps
    end
  end
end
