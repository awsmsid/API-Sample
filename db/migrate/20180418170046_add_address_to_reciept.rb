class AddAddressToReciept < ActiveRecord::Migration[5.1]
  def change
    add_column :reciepts, :address, :string
  end
end
