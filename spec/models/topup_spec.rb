# frozen_string_literal: true

require 'rails_helper'

describe Topup do
  let(:amount) { 10 }
  let(:topup_method) { 'test' }
  let(:result) { 'pass' }
  let(:top_up) do
    described_class.new(amount: amount,
                        method: topup_method,
                        result: result)
  end

  describe 'validate' do
    subject { top_up.valid? }

    context 'with empty account_no' do
      let(:amount) { nil }

      it { is_expected.to eq false }
    end

    context 'with empty utility_type' do
      let(:topup_method) { nil }

      it { is_expected.to eq false }
    end

    context 'with empty company_name' do
      let(:result) { nil }

      it { is_expected.to eq false }
    end
  end
end
