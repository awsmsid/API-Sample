# frozen_string_literal: true

FactoryBot.define do
  factory :account do
    bank_name 'test'
    bsb 123_456
    account_number '1o409175049'
    account_name 'test'
  end
end
