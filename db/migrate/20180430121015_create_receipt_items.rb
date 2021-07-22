class CreateReceiptItems < ActiveRecord::Migration[5.1]
  def change
    create_table :receipt_items do |t|
    	t.integer :receipt_id
    	t.string :item_name
    	t.integer :quantity
    	t.string :price
      	t.timestamps
    end
  end
end
