# frozen_string_literal: true

class Login
  include ActiveModel::Validations

  attr_accessor :id, :email, :password, :token, :user

  def initialize(id: nil, email: nil, password: nil, token: nil)
    @id = id
    @password = password
    @email = email
    @token = token
  end
end
