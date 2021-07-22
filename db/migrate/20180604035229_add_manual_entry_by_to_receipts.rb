class AddManualEntryByToReceipts < ActiveRecord::Migration[5.1]
  def change
    add_column :receipts, :manual_entry_by, :integer
  end
end
