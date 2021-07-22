class AddTransactionIdToTopups < ActiveRecord::Migration[5.1]
  def change
    add_column :topups, :transaction_id, :integer
  end
end
