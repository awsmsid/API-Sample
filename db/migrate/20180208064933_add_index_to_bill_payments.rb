class AddIndexToBillPayments < ActiveRecord::Migration[5.1]
  def change
    add_index :bill_payments, :user_id
  end
end
