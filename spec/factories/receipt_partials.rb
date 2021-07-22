# frozen_string_literal: true

FactoryBot.define do
  factory :receipt_partial do
    receipt_id 1
    trait :skip_validate do
      to_create { |instance| instance.save(validate: false) }
    end
  end
end
