class AddIsDeletedToUtilityTypes < ActiveRecord::Migration[5.1]
  def change
    add_column :utility_types, :is_deleted, :boolean, default: false
  end
end
