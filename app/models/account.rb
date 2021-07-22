# frozen_string_literal: true

class Account < ApplicationRecord
  validates :bank_name, :bsb, :account_number, :account_name, presence: true
  validates :bsb,
            length: { maximum: 6, minimum: 6 },
            numericality: true
  has_many :accounts, dependent: :destroy
end
