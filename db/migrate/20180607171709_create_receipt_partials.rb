class CreateReceiptPartials < ActiveRecord::Migration[5.1]
  def change
    create_table :receipt_partials do |t|
      t.integer :user_id
      t.attachment :picture
      t.string :status
      t.timestamps
    end
    add_index :receipt_partials, :user_id
  end
end
