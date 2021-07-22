# frozen_string_literal: true

class Game < ApplicationRecord
  validates :game_id, :user_id, presence: true
  belongs_to :user
end
