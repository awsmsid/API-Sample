class AddReceiptPartialIdToReceiptItems < ActiveRecord::Migration[5.1]
  def change
    add_column :receipt_items, :receipt_partial_id, :integer
    add_index :receipt_items, :receipt_partial_id
  end
end
