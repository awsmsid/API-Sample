class AddUserIdToBillPayments < ActiveRecord::Migration[5.1]
  def change
    add_column :bill_payments, :user_id, :string
  end
end
