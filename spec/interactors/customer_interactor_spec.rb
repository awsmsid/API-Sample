# frozen_string_literal: true

require 'rails_helper'

describe CustomerInteractor do
  let(:customer) { instance_double('customer') }
  let(:existing_customer) { instance_double('customer') }

  describe '.try_save' do
    before do
      allow(customer).to receive(:user_id).and_return(1)
      allow(Customer).to receive(:find_by_user_id) { existing_customer }
    end

    subject { described_class.try_save(customer) }

    it 'is failed when customer exist' do
      expect { subject }.to raise_error(RecordExistError::CustomerExistError)
    end

    context 'when customer not exist save success' do
      let(:existing_customer) { nil }

      before do
        allow(customer).to receive(:save).and_return(true)
      end

      it { is_expected.to eq customer }
    end
  end

  describe '.try_update' do
    let(:params) do
      { id: 1 }
    end

    subject { described_class.try_update(customer, params) }

    before do
      allow(Customer).to receive(:find_by_user_id) { customer }
    end

    context 'when customer exist update success' do
      before do
        allow(customer).to receive(:update).and_return(true)
      end

      it { is_expected.to eq customer }
    end

    context 'when customer not exist' do
      let(:customer) { nil }

      it 'is failed' do
        expect { subject }.to raise_error(RecordNotExistError::CustomerDoesNotExistError)
      end
    end
  end
end
