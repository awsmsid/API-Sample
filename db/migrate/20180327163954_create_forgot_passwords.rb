class CreateForgotPasswords < ActiveRecord::Migration[5.1]
  def change
    create_table :forgot_passwords do |t|
      t.string :token
      t.datetime :expiry

      t.timestamps
    end
  end
end
