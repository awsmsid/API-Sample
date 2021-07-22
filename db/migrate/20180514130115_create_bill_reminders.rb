class CreateBillReminders < ActiveRecord::Migration[5.1]
  def change
    create_table :bill_reminders do |t|
      t.string :title
      t.integer :all_day
      t.integer :start_date
      t.integer :end_date
      t.integer :user_id

      t.timestamps
    end
    add_index :bill_reminders, :user_id
  end
end
