class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.string :bank_name
      t.integer :bsb, :limit => 6
      t.string :account_number
      t.string :account_name

      t.timestamps
    end
  end
end
