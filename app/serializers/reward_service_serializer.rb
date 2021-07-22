# frozen_string_literal: true

class RewardServiceSerializer
  include JSONAPI::Serializer

  TYPE = 'reward_service'
  attribute :game_token
  attribute :credit_money
  attribute :user_id
end
