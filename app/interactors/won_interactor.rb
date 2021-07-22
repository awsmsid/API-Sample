# frozen_string_literal: true

class WonInteractor
  def self.create_won(params, user_id)
    reward_service = RewardService.find_by_user_id(user_id)
    raise 'reward service not found' if reward_service.blank?
    update_won(params, reward_service)
  end

  def self.update_won(params, reward_service)
    level_price = JSON ENV['WON_LEVEL_PRICE']
    reward_money = level_price.at(params[:level].to_i - 1)
    credit_money = reward_service.credit_money
    total_money = reward_money + credit_money
    if reward_service.update(credit_money: total_money.to_i)
      { body: JSONAPI::Serializer.serialize(reward_service), code: 200 }
    else
      { body: { 'error' => reward_service.errors }, code: 422 }
    end
  end
end
