class AddDeletedAtReceipt < ActiveRecord::Migration[5.1]
  def change
    add_column :receipts, :deleted_at, :datetime
  end
end
