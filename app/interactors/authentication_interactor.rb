# frozen_string_literal: true

class AuthenticationInteractor
  attr_accessor :token

  def initialize(token)
    @token = token
  end

  def user_from_token
    User.find_by_token(token)
  end
end
