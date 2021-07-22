# frozen_string_literal: true

class Topup < ApplicationRecord
  validates :amount, :method, :result, :transaction_id, presence: true
  validates :transaction_id, uniqueness: true
  belongs_to :user
end
