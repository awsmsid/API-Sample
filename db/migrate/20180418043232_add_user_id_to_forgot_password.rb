class AddUserIdToForgotPassword < ActiveRecord::Migration[5.1]
  def change
    add_column :forgot_passwords, :user_id, :integer
    add_index :forgot_passwords, :user_id
  end
end
