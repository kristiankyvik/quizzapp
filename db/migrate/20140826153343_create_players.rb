class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :username
      t.integer :game_id
      t.integer :score, :default => 0
      t.timestamps
    end
  end
end
