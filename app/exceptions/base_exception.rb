# frozen_string_literal: true

class BaseException < StandardError
  include JSONAPI::Serializer

  attr_reader :status, :code, :message

  ERROR_DESCRIPTION = proc do |code, message|
    { status: 'error', code: code, message: message }
  end

  ERROR_CODE_MAP = {
    'RecordExistError::CustomerExistError' =>
      ERROR_DESCRIPTION.call(1000, 'customer record already exist please update instead'),
    'RecordNotExistError::CustomerDoesNotExistError' =>
        ERROR_DESCRIPTION.call(1001, 'customer record not exist please create first')
  }.freeze

  def initialize
    error_type = self.class.name
    BaseException::ERROR_CODE_MAP.fetch(error_type, {}).each do |attr, value|
      instance_variable_set("@#{attr}".to_sym, value)
    end
  end

  def to_hash
    { status: status,
      code: code,
      message: message }
  end
end
