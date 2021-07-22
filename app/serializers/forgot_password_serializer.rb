# frozen_string_literal: true

class ForgotPasswordSerializer
  include JSONAPI::Serializer

  TYPE = 'forgot_password'
  attribute :token
end
