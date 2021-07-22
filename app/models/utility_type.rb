# frozen_string_literal: true

class UtilityType < ApplicationRecord
  validates :name, presence: true
  has_many :bill_payments, dependent: :destroy
end
