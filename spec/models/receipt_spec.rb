# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Receipt, type: :model do
  let(:name) { 'IGA' }
  let(:reciept_date) { Time.zone.now }
  let(:user_id) { 1 }
  let(:reciept) do
    described_class.new(name: name,
                        receipt_date: reciept_date,
                        user_id: user_id)
  end

  describe 'validate' do
    subject { reciept.valid? }

    context 'with empty name' do
      let(:name) { nil }

      it { is_expected.to eq false }
    end

    context 'with reciept date' do
      let(:reciept_date) { nil }

      it { is_expected.to eq false }
    end

    context 'with user id' do
      let(:user_id) { nil }

      it { is_expected.to eq false }
    end
  end
end
