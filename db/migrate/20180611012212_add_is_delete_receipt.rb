class AddIsDeleteReceipt < ActiveRecord::Migration[5.1]
  def change
    add_column :receipts, :is_deleted, :boolean, default: false
  end
end
