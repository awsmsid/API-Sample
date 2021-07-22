class RenameTableRecieptToReceipt < ActiveRecord::Migration[5.1]
  def change
  	rename_table :reciepts, :receipts
  	rename_column :receipts, :reciept_date, :receipt_date
  end
end
