# frozen_string_literal: true

require 'rails_helper'

describe ReceiptsProcessingJob do
  let(:reward_service) { instance_double('reward_service') }

  let(:woolworths_wa) do
    read_fixtures('woolworths_wa.json')
  end

  let(:iga_store_name_not_found_json) do
    read_fixtures('iga_store_name_not_found.json')
  end

  let(:receipt_without_name) do
    read_fixtures('receipt_without_name.json')
  end

  describe '.perform_later' do
    receipt = FactoryBot.create(:receipt, :skip_validate)

    subject do
      described_class.perform_now(receipt.id)
    end

    before do
      allow(OCRSpaceService)
        .to receive(:upload).with(any_args) { woolworths_wa }
    end

    context 'when store name found' do
      it { is_expected.to be_instance_of(Receipt) }
    end
  end

  describe '.perform_later' do
    receipt = FactoryBot.create(:receipt, :skip_validate)
    receipt_partial = ReceiptPartial.new(receipt_id: receipt.id)
    receipt_partial.save(validate: false)

    subject do
      described_class.perform_now(receipt.id)
    end

    before do
      allow(OCRSpaceService)
        .to receive(:upload).with(any_args) { woolworths_wa }
    end

    context 'when receipt partial updated' do
      it { is_expected.to eq nil }
    end
  end

  describe '.perform_later' do
    receipt = FactoryBot.create(:receipt, :skip_validate)
    receipt_partial = ReceiptPartial.new(receipt_id: receipt.id)
    receipt_partial.save(validate: false)

    subject do
      described_class.perform_now(receipt.id)
    end

    before do
      allow(OCRSpaceService)
        .to receive(:upload).with(any_args) { iga_store_name_not_found_json }
    end

    context 'when max size exceeded' do
      it { is_expected.to eq nil }
    end
  end

  describe '.perform_later' do
    receipt = FactoryBot.create(:receipt, :skip_validate)
    receipt_partial = ReceiptPartial.new(receipt_id: receipt.id)
    receipt_partial.save(validate: false)

    subject do
      described_class.perform_now(receipt.id)
    end

    before do
      allow(OCRSpaceService)
        .to receive(:upload).with(any_args) { receipt_without_name }
    end

    context 'when receipt partial updated' do
      it { is_expected.to eq nil }
    end
  end

  describe '.update_reward_services' do
    receipt = FactoryBot.create(:receipt, :skip_validate)

    subject do
      described_class.perform_now(receipt.id)
    end

    before do
      allow(RewardService).to receive(:find_by_user_id).and_return(reward_service)
      allow(reward_service).to receive(:blank?).and_return(false)
      allow(reward_service).to receive(:game_token).and_return(true)
      allow(receipt).to receive(:mivi_credit).and_return(true)
      allow(reward_service).to receive(:save).and_return(true)
      allow(OCRSpaceService)
        .to receive(:upload).with(any_args) { receipt_without_name }
    end

    context 'when receipt partial updated' do
      it { is_expected.to be_instance_of(Receipt) }
    end
  end
end
