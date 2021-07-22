# frozen_string_literal: true

require 'rails_helper'

describe ManualProcessingsController do
  let(:manual_processings) do
    [ManualProcessing.new(id: 1, receipt_id: 1)]
  end
  let(:manual_processing) { instance_double('manual_processing') }
  let(:receipt_id) { 1 }

  before do
    allow(controller).to receive(:verify_api).and_return(true)
    allow(ManualProcessingInteractor).to receive(:index).with(any_args)
                                                        .and_return(manual_processings)
  end

  describe 'GET index' do
    subject { get :index }

    context 'when success' do
      it { is_expected.to have_http_status(:ok) }
    end
  end

  describe 'PATCH update' do
    subject { patch :update, params: params }

    before do
      allow(manual_processing).to receive(:update).and_return(true)
      allow(ManualProcessing).to receive(:find).and_return(manual_processing)
      allow(JSONAPI::Serializer).to receive(:serialize).with(manual_processing)
      allow(manual_processing).to receive(:errors).and_return([])
    end

    context 'when success' do
      let(:params) do
        {
          data: {
            type: 'bill-company',
            attributes: {

            }
          },
          id: receipt_id
        }
      end

      it { is_expected.to have_http_status(:ok) }
    end

    context 'when failed' do
      let(:params) do
        {
          data: {
            type: 'bill-company',
            attributes: {

            }
          },
          id: receipt_id
        }
      end

      before do
        allow(manual_processing).to receive(:update).and_return(false)
      end

      it { is_expected.to have_http_status(:unprocessable_entity) }
    end
  end
end
