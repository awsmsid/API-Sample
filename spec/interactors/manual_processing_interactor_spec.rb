# frozen_string_literal: true

require 'rails_helper'

describe ManualProcessingInteractor do
  let(:manual_processing) { instance_double('bill_payment', user_id: nil) }
  let(:user_id) { 1 }
  let(:params) do
    {
      mine: 'true'
    }
  end

  before do
    allow(ManualProcessing).to receive(:where).with(any_args).and_return(manual_processing)
  end

  describe '.index' do
    subject { described_class.index(params, user_id) }

    context 'when filter is present' do
      it { is_expected.to eq manual_processing }
    end

    context 'when filter is not present' do
      let(:params) do
        {
          mine: 'false'
        }
      end

      it { is_expected.to eq manual_processing }
    end
  end
end
