class CreateTransfers < ActiveRecord::Migration[5.1]
  def change
    create_table :transfers do |t|
      t.integer :user_id
      t.string :transfer_to
      t.integer :amount

      t.timestamps
    end
    add_index :transfers, :user_id
  end
end
