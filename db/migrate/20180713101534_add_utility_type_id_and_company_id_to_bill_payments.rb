class AddUtilityTypeIdAndCompanyIdToBillPayments < ActiveRecord::Migration[5.1]
  def change
    add_column :bill_payments, :utility_type_id, :integer
    add_column :bill_payments, :bill_company_id, :integer
    add_index :bill_payments, :utility_type_id
    add_index :bill_payments, :bill_company_id
  end
end
