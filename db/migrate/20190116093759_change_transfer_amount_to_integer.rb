class ChangeTransferAmountToInteger < ActiveRecord::Migration[5.1]
  def change
    change_column :transfers, :amount, :integer
  end
end
