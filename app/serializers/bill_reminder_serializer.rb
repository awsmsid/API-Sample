# frozen_string_literal: true

class BillReminderSerializer
  include JSONAPI::Serializer

  TYPE = 'bill_reminder'

  attribute :id
  attribute :user_id
  attribute :title
  attribute :all_day

  attribute :start_date do
    Time.zone.at(object.start_date)&.strftime('%d/%m/%Y %H:%M:%S')
  end

  attribute :end_date do
    Time.zone.at(object.end_date)&.strftime('%d/%m/%Y %H:%M:%S')
  end
end
