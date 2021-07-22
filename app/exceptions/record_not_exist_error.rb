# frozen_string_literal: true

class RecordNotExistError < BaseException
  class CustomerDoesNotExistError < RecordExistError
  end
end
