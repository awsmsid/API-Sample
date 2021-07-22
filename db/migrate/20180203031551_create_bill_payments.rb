class CreateBillPayments < ActiveRecord::Migration[5.1]
  def change
    create_table :bill_payments do |t|
      t.string :account_no
      t.string :utility_type
      t.string :company_name
      t.decimal :bill_amount, precision: 10, scale: 3

      t.timestamps
    end
  end
end
