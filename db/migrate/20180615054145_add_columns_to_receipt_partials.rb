class AddColumnsToReceiptPartials < ActiveRecord::Migration[5.1]
  def change
  	add_column :receipt_partials, :name, :string
  	add_column :receipt_partials, :receipt_date, :datetime
  	add_column :receipt_partials, :user_id, :integer
  	add_column :receipt_partials, :address, :string
  	add_column :receipt_partials, :total_paid, :string
  	add_column :receipt_partials, :status, :integer
  	add_column :receipt_partials, :manual_entry_by, :integer
  	add_column :receipt_partials, :is_deleted, :boolean, default: false
  	add_column :receipt_partials, :deleted_at, :datetime
  	add_index :receipt_partials, :user_id
  	add_index :receipt_partials, :manual_entry_by
  end
end
