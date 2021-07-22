# frozen_string_literal: true

class StartGameController < ApplicationController
  before_action :verify_api
  before_action :set_game, only: %i[update]

  def create
    response = StartGameInteractor.create_game(@user_id)
    render json: response[:body], status: response[:code]
  end

  def update
    if @game.update(start_game_params)
      render json: JSONAPI::Serializer.serialize(@game),
             status: :ok
    else
      render_errors(@game)
    end
  end

  private

  def start_game_params
    permitted = %i[amount]
    params.require(:data)
          .require(:attributes)
          .permit(permitted)
          .transform_keys(&:underscore)
  end

  def set_game
    @game = Game.find_by_game_id(params[:id])
  end
end
