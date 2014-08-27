class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :cheatsheet, :array => true
      t.timestamps
    end
  end
end
