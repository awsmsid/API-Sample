class CreateReciepts < ActiveRecord::Migration[5.1]
  def change
    create_table :reciepts do |t|
      t.string :name
      t.datetime :reciept_date
      t.integer :user_id

      t.timestamps
    end
    add_index :reciepts, :user_id
  end
end
