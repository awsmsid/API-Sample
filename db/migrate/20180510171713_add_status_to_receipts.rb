class AddStatusToReceipts < ActiveRecord::Migration[5.1]
  def change
    add_column :receipts, :status, :integer
  end
end
