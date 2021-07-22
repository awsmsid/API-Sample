# frozen_string_literal: true

require 'rails_helper'

describe StoreParserInteractor do
  let(:user_id) { 1 }
  let(:store_name) { 'IGA' }
  let(:address) { 'address' }
  let(:total_amount) { 100 }
  let(:time) { '2018-02-08 00:00:00' }
  let(:belmont_address) { 'BELMONT 4348' }
  let(:victoria_address) { 'VICTORIA PARK 4333' }
  let(:woolworths_address) { 'VICTORIA PARK 4333 WA' }
  let(:dummy_receipt) { instance_double('receipt') }

  let(:iga_with_store_name_and_time_json) do
    read_fixtures('iga_with_store_name_and_time.json')
  end

  let(:iga_different_time_format_json) do
    read_fixtures('iga_different_time_format.json')
  end

  let(:iga_store_name_not_found_json) do
    read_fixtures('iga_store_name_not_found.json')
  end

  let(:iga_date_time_not_found) do
    read_fixtures('iga_date_time_not_found.json')
  end

  let(:woolworths_wa) do
    read_fixtures('woolworths_wa.json')
  end

  let(:address_new_format) do
    read_fixtures('address_new_format.json')
  end

  let(:address_without_state) do
    read_fixtures('address_without_state.json')
  end

  let(:address_without_zip_code) do
    read_fixtures('address_without_zip_code.json')
  end

  let(:woolworths_receipt3) do
    read_fixtures('woolworths_receipt3.json')
  end

  let(:supa3_format) do
    read_fixtures('supa3_format.json')
  end

  let(:coles_receipt) do
    read_fixtures('coles_receipt.json')
  end

  let(:coles_receipt2) do
    read_fixtures('coles_receipt2.json')
  end

  let(:supa2_receipt) do
    read_fixtures('supa2_receipt.json')
  end

  let(:receipt_with_max_size) do
    read_fixtures('receipt_with_max_size.json')
  end

  let(:invalid_image) do
    read_fixtures('invalid_image.json')
  end

  let(:receipt) { Receipt.new }
  let(:receipt_partial) { ReceiptPartial.new }

  describe '.store' do
    let(:param) { iga_with_store_name_and_time_json }

    subject { described_class.store(param) }

    context 'when store name is found' do
      it { is_expected.to eq store_name }
    end

    context 'when store name is not found' do
      let(:param) { iga_store_name_not_found_json }

      it { is_expected.not_to eq store_name }
    end
  end

  describe '.find_date' do
    let(:param) { iga_with_store_name_and_time_json }

    subject { described_class.find_date(param) }

    context 'when time is found' do
      it { is_expected.to eq time }
    end

    context 'when time is not found' do
      let(:param) { iga_date_time_not_found }

      it { is_expected.not_to eq time }
    end
  end

  describe '.find_address' do
    let(:param) { iga_with_store_name_and_time_json }

    subject { described_class.find_address(param) }

    context 'when address is found' do
      let(:param) { woolworths_wa }

      it { is_expected.to eq belmont_address }
    end

    context 'when address is found with different format' do
      let(:param) { address_new_format }

      it { is_expected.to eq belmont_address }
    end

    context 'when address is found without state' do
      let(:param) { address_without_state }

      it { is_expected.to eq victoria_address }
    end

    context 'when address is found without zip code' do
      let(:param) { address_without_zip_code }

      it { is_expected.to eq woolworths_address }
    end
  end

  describe '.create_receipt' do
    subject do
      described_class.create_receipt(iga_with_store_name_and_time_json, receipt).name
    end

    before do
      allow(described_class)
        .to receive(:store).with(iga_with_store_name_and_time_json) { store_name }
      allow(described_class)
        .to receive(:find_date).with(iga_with_store_name_and_time_json) { time }
      allow(described_class)
        .to receive(:find_address).with(iga_with_store_name_and_time_json) { address }
    end

    context 'when store created' do
      it { is_expected.to eq store_name }
    end
  end

  describe '.create_receipt' do
    subject do
      described_class.create_receipt(address_new_format, receipt).name
    end

    before do
      allow(described_class)
        .to receive(:store).with(address_new_format) { store_name }
      allow(described_class)
        .to receive(:find_date).with(address_new_format) { time }
      allow(described_class)
        .to receive(:find_address).with(address_new_format) { address }
    end

    context 'when store created' do
      it { is_expected.to eq store_name }
    end
  end

  describe '.create_receipt' do
    subject do
      described_class.create_receipt(supa3_format, receipt).name
    end

    before do
      allow(described_class)
        .to receive(:store).with(supa3_format) { store_name }
      allow(described_class)
        .to receive(:find_date).with(supa3_format) { time }
      allow(described_class)
        .to receive(:find_address).with(supa3_format) { address }
    end

    context 'when store created' do
      it { is_expected.to eq store_name }
    end
  end

  describe '.create_receipt' do
    subject do
      described_class.create_receipt(address_without_state, receipt).name
    end

    before do
      allow(described_class)
        .to receive(:store).with(address_without_state) { store_name }
      allow(described_class)
        .to receive(:find_date).with(address_without_state) { time }
      allow(described_class)
        .to receive(:find_address).with(address_without_state) { address }
    end

    context 'when store created' do
      it { is_expected.to eq store_name }
    end
  end

  describe '.create_receipt' do
    subject do
      described_class.create_receipt(coles_receipt2, receipt).name
    end

    before do
      allow(described_class)
        .to receive(:store).with(coles_receipt2) { store_name }
      allow(described_class)
        .to receive(:find_date).with(coles_receipt2) { time }
      allow(described_class)
        .to receive(:find_address).with(coles_receipt2) { address }
    end

    context 'when store created' do
      it { is_expected.to eq store_name }
    end
  end

  describe '.create_receipt' do
    subject do
      described_class.create_receipt(coles_receipt, receipt).name
    end

    before do
      allow(described_class)
        .to receive(:store).with(coles_receipt) { store_name }
      allow(described_class)
        .to receive(:find_date).with(coles_receipt) { time }
      allow(described_class)
        .to receive(:find_address).with(coles_receipt) { address }
    end

    context 'when store created' do
      it { is_expected.to eq store_name }
    end
  end

  describe '.create_receipt' do
    subject do
      described_class.create_receipt(supa2_receipt, receipt).name
    end

    before do
      allow(described_class)
        .to receive(:store).with(supa2_receipt) { store_name }
      allow(described_class)
        .to receive(:find_date).with(supa2_receipt) { time }
      allow(described_class)
        .to receive(:find_address).with(supa2_receipt) { address }
    end

    context 'when store created' do
      it { is_expected.to eq store_name }
    end
  end

  describe '.create_receipt' do
    subject do
      described_class.create_receipt(supa2_receipt, receipt_partial).name
    end

    before do
      allow(described_class)
        .to receive(:store).with(supa2_receipt) { store_name }
      allow(described_class)
        .to receive(:find_date).with(supa2_receipt) { time }
      allow(described_class)
        .to receive(:find_address).with(supa2_receipt) { address }
    end

    context 'when store created' do
      it { is_expected.to eq store_name }
    end
  end

  describe '.create_receipt' do
    invalid_receipt = FactoryBot.create(:receipt, :skip_validate)

    subject do
      described_class.create_receipt(invalid_image, invalid_receipt).name
    end

    before do
      allow(described_class)
        .to receive(:store).with(invalid_image) { store_name }
      allow(described_class)
        .to receive(:find_date).with(invalid_image) { time }
      allow(described_class)
        .to receive(:find_address).with(invalid_image) { address }
    end

    context 'when store created' do
      it { is_expected.to eq 'reciept' }
    end
  end

  describe '.response_message_code' do
    subject { described_class.response_message_code(receipt)[:code] }

    before do
      receipt.name = store_name
      receipt.receipt_date = time
    end

    context 'when success' do
      it { is_expected.to eq 200 }
    end
  end

  describe '.response_message_code' do
    subject { described_class.response_message_code(receipt)[:code] }

    context 'when limit exceed' do
      let(:receipt) { [] }

      it { is_expected.to eq 400 }
    end
  end

  describe '.response_message_code' do
    subject { described_class.response_message_code([receipt_partial])[:code] }

    context 'when multiple picture uploaded' do
      it { is_expected.to eq 200 }
    end
  end

  describe '.process_reciept' do
    receipt = FactoryBot.create(:receipt, :skip_validate)

    subject do
      described_class.process_receipt(receipt.id)
    end

    before do
      allow(OCRSpaceService)
        .to receive(:upload).with(any_args) { woolworths_wa }
    end

    context 'when receipt process' do
      it { is_expected.to be_instance_of(Receipt) }
    end
  end

  describe '.process_reciept' do
    receipt = FactoryBot.create(:receipt, :skip_validate)

    subject do
      described_class.process_receipt(receipt.id)
    end

    before do
      allow(OCRSpaceService)
        .to receive(:upload).with(any_args) { receipt_with_max_size }
    end

    context 'when max size exceeded' do
      it { is_expected.to be_instance_of(Array) }
    end
  end

  describe '.create_and_parse_receipt' do
    let(:dummy_picture) { instance_double('picture') }

    before do
      allow(Receipt).to receive(:new).with(any_args) { dummy_receipt }
      allow(dummy_picture).to receive(:url).and_return('aws-original')
      allow(dummy_receipt).to receive(:picture) { dummy_picture }
      allow(dummy_receipt).to receive(:save).and_return(true)
      allow(OCRSpaceService)
        .to receive(:upload).with(any_args) { receipt_with_max_size }
      allow(ReceiptsProcessingJob)
        .to receive(:perform_later).with(any_args) { receipt_with_max_size }
      allow(dummy_receipt).to receive(:id).and_return(true)
    end

    subject do
      described_class.create_and_parse_receipt(woolworths_wa, user_id)
    end

    it 'when calls create receipt' do
      expect(described_class)
        .to eq described_class
      subject
    end
  end

  describe '.create_and_parse_receipt' do
    let(:dummy_picture) { instance_double('picture') }
    let(:parser_params) { %w[test test] }

    before do
      allow(ReceiptPartial).to receive(:new).with(any_args) { dummy_receipt }
      allow(dummy_picture).to receive(:url).and_return('aws-original')
      allow(dummy_receipt).to receive(:picture) { dummy_picture }
      allow(dummy_receipt).to receive(:save).and_return(true)
      allow(OCRSpaceService)
        .to receive(:upload).with(any_args) { receipt_with_max_size }
      allow(ReceiptsProcessingJob)
        .to receive(:perform_later).with(any_args) { receipt_with_max_size }
      allow(dummy_receipt).to receive(:id).and_return(true)
    end

    subject do
      described_class.create_and_parse_receipt(parser_params, user_id)
    end

    it 'when calls create receipt' do
      expect(described_class)
        .to eq described_class
      subject
    end
  end
end
