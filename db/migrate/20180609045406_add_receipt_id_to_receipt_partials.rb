class AddReceiptIdToReceiptPartials < ActiveRecord::Migration[5.1]
  def change
    add_column :receipt_partials, :receipt_id, :integer
    remove_column :receipt_partials, :user_id, :integer
    remove_column :receipt_partials, :status,  :string
    add_index :receipt_partials, :receipt_id
  end
end
