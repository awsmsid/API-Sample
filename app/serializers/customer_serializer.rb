# frozen_string_literal: true

class CustomerSerializer
  include JSONAPI::Serializer

  TYPE = 'customer'

  attribute :id
  attribute :user_id
  attribute :full_name
  attribute :dob
  attribute :gender
  attribute :email
  attribute :phone_number
  attribute :website
  attribute :address
  attribute :interests
end
