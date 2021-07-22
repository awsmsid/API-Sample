class CreateTransactionView < ActiveRecord::Migration[5.1]
  def up
    sql_command = %{
	    CREATE VIEW transaction_view AS
		    SELECT u.fullname, u.id AS user_id, u.email, u.mobile_number, u.token, u.gender, u.dob, t.id AS topup_id, t.amount AS topup_amount, t.method, t.result, w.id AS withdraw_id, w.account_to, w.amount AS withdraw_amount,
			   CONCAT(t.updated_at, ',', w.updated_at, ',', tf.updated_at) AS updated_at,
			   CONCAT(t.created_at, ',', w.created_at, ',', tf.created_at) AS created_at,
			   CONCAT(tf.id, ',', tf.transfer_to) AS transfer,
			   tf.amount AS transfer_amount
			  FROM users u
			  INNER JOIN topups t
			    ON u.id = t.user_id
			  INNER JOIN withdraws w
			    ON u.id = w.user_id
			  INNER JOIN transfers tf
			    ON u.id = tf.user_id
			  ORDER BY user_id ASC
		}
    execute sql_command
  end

  def down
    sql_command = "DROP VIEW transaction_view"
    execute sql_command
  end
end
