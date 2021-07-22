class AddIsDeletedToBillCompanies < ActiveRecord::Migration[5.1]
  def change
    add_column :bill_companies, :is_deleted, :boolean, default: false
  end
end
