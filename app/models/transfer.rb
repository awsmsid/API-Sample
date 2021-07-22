# frozen_string_literal: true

class Transfer < ApplicationRecord
  validates :transfer_to, :amount, presence: true
end
