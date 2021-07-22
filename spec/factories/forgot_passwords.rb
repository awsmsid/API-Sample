# frozen_string_literal: true

FactoryBot.define do
  factory :forgot_password do
    expiry { Time.zone.now }
    token { 'xyz123abc' }
    user_id { 1 }
  end
end
