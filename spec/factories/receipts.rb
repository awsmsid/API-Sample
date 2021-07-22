# frozen_string_literal: true

FactoryBot.define do
  factory :receipt do
    name { 'reciept' }
    receipt_date { Time.zone.now }
    user_id { 1 }
    trait :skip_validate do
      to_create { |instance| instance.save(validate: false) }
    end
  end
end
