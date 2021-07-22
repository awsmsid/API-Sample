# frozen_string_literal: true

class RewardServiceInteractor
  def self.create(params)
    rs = RewardService.find_by_user_id(params[:user_id])
    if rs.blank?
      reward_service = RewardService.new(params)
      reward_service.save(validate: false)
      { body: JSONAPI::Serializer.serialize(reward_service), code: 200 }
    else
      { body: { 'error' => 'record already exist use PATCH instead' }, code: 400 }
    end
  end
end
