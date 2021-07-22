class CreateGames < ActiveRecord::Migration[5.1]
  def change
    create_table :games do |t|
      t.integer :user_id
      t.integer :amount
      t.string :game_id

      t.timestamps
    end
    add_index :games, :user_id
    add_index :games, :game_id
  end
end
