class CreateManualProcessings < ActiveRecord::Migration[5.1]
  def change
    create_table :manual_processings do |t|
      t.string :receipt_id

      t.timestamps
    end
    add_index :manual_processings, :receipt_id
  end
end
