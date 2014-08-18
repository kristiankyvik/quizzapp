class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :title
      t.string :song
      t.text :explanation
      t.timestamps
    end
  end
end
