class AddProcessByToManualProcessing < ActiveRecord::Migration[5.1]
  def change
    add_column :manual_processings, :process_by, :integer
  end
end
