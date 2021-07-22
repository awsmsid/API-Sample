# frozen_string_literal: true

class BillCompany < ApplicationRecord
  validates :name, presence: true
  has_many :bill_payments, dependent: :destroy
end
