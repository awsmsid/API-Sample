class CreateRewardServices < ActiveRecord::Migration[5.1]
  def change
    create_table :reward_services do |t|
      t.integer :game_token, limit: 8
      t.integer :credit_money
      t.integer :user_id

      t.timestamps
    end
    add_index :reward_services, :user_id
  end
end
