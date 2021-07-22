class CreateCustomers < ActiveRecord::Migration[5.1]
  def change
    create_table :customers do |t|
      t.string :user_id
      t.string :full_name
      t.string :email
      t.string :website
      t.string :phone_number
      t.string :gender
      t.timestamp :dob
      t.string :address
      t.string :interests
    end
  end
end
