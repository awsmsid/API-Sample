class ModifyTransactionView < ActiveRecord::Migration[5.1]
  def up
  	sql_command = "DROP VIEW transaction_view"
    execute sql_command

    sql_command = %{
	    CREATE VIEW transaction_view AS
		    SELECT tup.id AS topup_id, tup.amount AS topup_amount, tup.method, tup.result, wd.id AS withdraw_id, wd.account_to, wd.amount AS withdraw_amount,
				CONCAT_WS(',', tup.updated_at, wd.updated_at, trans.updated_at) AS updated_at,
			  CONCAT_WS(',', tup.created_at, wd.created_at, trans.created_at) AS created_at,
				CONCAT_WS(',', trans.id, trans.transfer_to) AS transfer,
				trans.amount AS transfer_amount

				FROM users usr
				CROSS JOIN (SELECT generate_series n FROM generate_series(1, 3)) AS nr
				LEFT JOIN topups tup ON tup.user_id = usr.id AND nr.n = 1
				LEFT JOIN withdraws wd ON wd.user_id = usr.id AND nr.n = 2
				LEFT JOIN transfers trans ON trans.user_id = usr.id AND nr.n = 3
				WHERE (tup.user_id IS NOT NULL OR wd.user_id IS NOT NULL OR trans.user_id IS NOT NULL)
				ORDER BY tup.user_id, wd.user_id, trans.user_id
		}
    execute sql_command
  end

  def down
    sql_command = "DROP VIEW transaction_view"
    execute sql_command
  end
end
