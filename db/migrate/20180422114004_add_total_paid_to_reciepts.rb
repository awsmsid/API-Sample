class AddTotalPaidToReciepts < ActiveRecord::Migration[5.1]
  def change
    add_column :reciepts, :total_paid, :string
  end
end
