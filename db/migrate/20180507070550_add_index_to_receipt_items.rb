class AddIndexToReceiptItems < ActiveRecord::Migration[5.1]
  def change
  	add_index :receipt_items, :receipt_id
  end
end
