# frozen_string_literal: true

class BillPayment < ApplicationRecord
  validates :account_no, :utility_type_id, :bill_company_id, :bill_amount, presence: true
  belongs_to :utility_type
  belongs_to :bill_company
end
