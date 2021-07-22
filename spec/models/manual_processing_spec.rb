# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ManualProcessing, type: :model do
  let(:receipt_id) { 1 }
  let(:manual_processing) do
    described_class.new(receipt_id: receipt_id)
  end

  describe 'validate' do
    subject { manual_processing.valid? }

    context 'with empty receipt_id' do
      let(:receipt_id) { nil }

      it { is_expected.to eq false }
    end
  end
end
