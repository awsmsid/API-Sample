# frozen_string_literal: true

class Withdraw < ApplicationRecord
  validates :amount, :account_to, presence: true
  # rubocop:disable all
  belongs_to :account, foreign_key: 'account_to'
end
