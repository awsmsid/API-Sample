# frozen_string_literal: true

class TransferInteractor
  def self.create_transfer(params, user_id)
    reward_service_source = RewardService.find_by_user_id(user_id)
    if reward_service_source.blank?
      return { body: { 'error' => 'reward service does not exist' }, code: 422 }
    end

    transfer_amount = params[:amount] * 100 if params[:amount].to_s.include?('.')
    transfer_amount = transfer_amount.to_i

    unless reward_service_source.credit_money >= transfer_amount
      return { body: { 'error' => 'insufficient amount' }, code: 422 }
    end

    transfer = Transfer.new(params)
    transfer.amount = transfer_amount
    transfer_result = transfer.save
    unless transfer_result
      Rails.logger.info "save result #{transfer_result.inspect}"
      Rails.logger.info "transfer detail #{transfer.inspect}"
      Rails.logger.info "error detail #{transfer.errors.inspect}"
      return { body: { 'error' => 'something went wrong' }, code: 500 }
    end

    deducted_money = reward_service_source.credit_money - transfer_amount
    reward_service_source.update(credit_money: deducted_money)
    reward_service_beneficiary = RewardService.find_by_user_id(params[:transfer_to])
    added_money = reward_service_beneficiary.credit_money + transfer_amount
    reward_service_beneficiary.update(credit_money: added_money)
    { body: JSONAPI::Serializer.serialize(transfer), code: 200 }
  end
end
