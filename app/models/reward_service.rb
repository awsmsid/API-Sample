# frozen_string_literal: true

class RewardService < ApplicationRecord
  validates :user_id, presence: true
end
