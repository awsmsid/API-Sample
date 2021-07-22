# frozen_string_literal: true

class GameSerializer
  include JSONAPI::Serializer

  TYPE = 'game'
  attribute :user_id
  attribute :amount
  attribute :game_id

  attribute :created_at do
    object&.created_at&.strftime('%d/%m/%Y %H:%M:%S')
  end

  attribute :updated_at do
    object&.updated_at&.strftime('%d/%m/%Y %H:%M:%S')
  end
end
