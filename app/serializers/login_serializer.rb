# frozen_string_literal: true

class LoginSerializer
  include JSONAPI::Serializer

  TYPE = 'login'

  attribute :id
  attribute :token
  attribute :email
end
