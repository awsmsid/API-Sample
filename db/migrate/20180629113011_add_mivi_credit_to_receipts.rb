class AddMiviCreditToReceipts < ActiveRecord::Migration[5.1]
  def change
    add_column :receipts, :mivi_credit, :integer, default: 0
  end
end
