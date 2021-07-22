class AddIsDeletedToBillReminders < ActiveRecord::Migration[5.1]
  def change
    add_column :bill_reminders, :is_deleted, :boolean, default: false
  end
end
