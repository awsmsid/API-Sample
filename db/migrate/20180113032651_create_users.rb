class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :fullname
      t.string :email
      t.string :mobile_number
      t.string :token
      t.string :password
      t.string :gender
      t.timestamp :dob
      t.string :address
    end
  end
end
