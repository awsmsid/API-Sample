class AddProcessedToManualProcessing < ActiveRecord::Migration[5.1]
  def change
    add_column :manual_processings, :processed, :boolean, default: false
  end
end
