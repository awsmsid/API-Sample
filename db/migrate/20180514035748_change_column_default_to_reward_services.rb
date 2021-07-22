class ChangeColumnDefaultToRewardServices < ActiveRecord::Migration[5.1]
  def change
  	change_column_default :reward_services, :game_token, 0
  	change_column_default :reward_services, :credit_money, 0
  end
end
