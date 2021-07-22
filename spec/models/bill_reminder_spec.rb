# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BillReminder, type: :model do
  let(:user_id) { 1 }
  let(:title) { 'bill reminder1' }
  let(:all_day) { 0 }
  let(:start_date) { '1o409175049' }
  let(:end_date) { '1o409175049' }
  let(:bill_reminder) do
    described_class.new(user_id: user_id,
                        title: title,
                        all_day: all_day,
                        start_date: start_date,
                        end_date: end_date)
  end

  describe 'validate' do
    subject { bill_reminder.valid? }

    context 'with empty user id' do
      let(:user_id) { nil }

      it { is_expected.to eq false }
    end

    context 'with empty title' do
      let(:title) { nil }

      it { is_expected.to eq false }
    end
  end
end
