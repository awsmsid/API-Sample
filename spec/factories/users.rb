# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "saddam#{n}@mivi.com.au" }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
