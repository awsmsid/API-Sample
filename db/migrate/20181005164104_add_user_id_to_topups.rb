class AddUserIdToTopups < ActiveRecord::Migration[5.1]
  def change
    add_column :topups, :user_id, :integer
    add_index :topups, :user_id
  end
end
