# frozen_string_literal: true

class WithdrawInteractor
  def self.create_withdraw(withdraw_params, user_id)
    if user_account_exist?(withdraw_params)
      if amount_exist?(withdraw_params, user_id)
        withdraw = Withdraw.new(withdraw_params.merge(user_id: user_id))
        if withdraw.save
          { body: JSONAPI::Serializer.serialize(withdraw), code: 200 }
        else
          { body: { 'error' => withdraw.errors }, code: 422 }
        end
      else
        { body: { 'error' => 'insufficient amount' }, code: 422 }
      end
    else
      { body: { 'error' => 'Account does not exist' }, code: 422 }
    end
  end

  def self.user_account_exist?(withdraw_params)
    Account.where(id: withdraw_params[:account_to]).present?
  end

  def self.amount_exist?(withdraw_params, user_id)
    user = User.find(user_id)
    withdraw_params[:amount].to_i <= user.reward_service_credit_money
  end

  def self.index(user_id)
    accounts = Account.where(user_id: user_id)
    withdraws = if accounts.blank?
                  []
                else
                  Withdraw.where(account_to: accounts.map(&:id))
                end
    withdraws
  end
end
