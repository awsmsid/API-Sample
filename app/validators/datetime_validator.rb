# frozen_string_literal: true

class DatetimeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    value.to_datetime
  rescue StandardError
    record.errors[attribute] << (options[:message] || 'is not valid date')
  end
end
