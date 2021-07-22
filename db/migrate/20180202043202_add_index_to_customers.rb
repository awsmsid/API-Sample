class AddIndexToCustomers < ActiveRecord::Migration[5.1]
  def change
    add_index :customers, :user_id
  end
end
