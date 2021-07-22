class CreateWithdraws < ActiveRecord::Migration[5.1]
  def change
    create_table :withdraws do |t|
      t.integer :account_to, index: true
      t.integer :amount

      t.timestamps
    end
  end
end
