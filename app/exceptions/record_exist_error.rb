# frozen_string_literal: true

class RecordExistError < BaseException
  class CustomerExistError < RecordExistError
  end
end
