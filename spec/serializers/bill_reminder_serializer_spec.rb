# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BillReminderSerializer do
  let(:id) { 1 }
  let(:user_id) { 1 }
  let(:title) { 'Bill Reminder' }
  let(:all_day) { 0 }
  let(:start_date) { '1o409175049' }
  let(:end_date) { '1o409175049' }
  let(:bill_start_date) { '28/08/2014 03:00:49' }
  let(:bill_end_date) { '28/08/2014 03:00:49' }
  let(:bill_reminder) do
    BillReminder.new(
      user_id: user_id,
      title: title,
      all_day: all_day,
      start_date: start_date,
      end_date: end_date
    )
  end

  subject { JSONAPI::Serializer.serialize(bill_reminder) }

  it { is_expected.to have_jsonapi_attributes('user-id' => user_id) }

  it { is_expected.to have_jsonapi_attributes('title' => title) }

  it { is_expected.to have_jsonapi_attributes('all-day' => all_day) }
end
