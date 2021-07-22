class CreateTopups < ActiveRecord::Migration[5.1]
  def change
    create_table :topups do |t|
      t.decimal :amount
      t.string :method
      t.string :result

      t.timestamps
    end
  end
end
