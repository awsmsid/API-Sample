class CreateUtilityTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :utility_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
