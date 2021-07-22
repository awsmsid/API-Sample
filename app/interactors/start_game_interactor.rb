# frozen_string_literal: true

class StartGameInteractor
  def self.create_game(user_id)
    reward_service = RewardService.where(user_id: user_id)
    if reward_service.blank?
      { body: { 'error' => 'reward service does not exist' }, code: 422 }
    else
      game = Game.new(game_id: SecureRandom.uuid, user_id: user_id)
      if game.save
        update_reward_service(reward_service.last, game)
      else
        { body: { 'error' => game.errors }, code: 422 }
      end
    end
  end

  def self.update_reward_service(reward_service, game)
    game_token = reward_service.game_token - 1
    if reward_service.update(game_token: game_token)
      { body: JSONAPI::Serializer.serialize(game), code: 200 }
    else
      { body: { 'error' => reward_service.errors }, code: 422 }
    end
  end
end
