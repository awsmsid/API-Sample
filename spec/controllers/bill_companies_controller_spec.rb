# frozen_string_literal: true

require 'rails_helper'

describe BillCompaniesController do
  let(:bill_company) { instance_double('bill_company') }
  let(:bill_company_id) { 1 }
  let(:user_id) { 1 }
  let(:save_result) { true }
  let(:params) do
    {
      data: {
        type: 'BillCompany',
        attributes: {
          name: 'test'
        }
      }
    }
  end

  before do
    allow(controller).to receive(:verify_api).and_return(true)
    allow(bill_company).to receive(:[]=).with(:user_id, user_id)
    allow(bill_company).to receive(:valid?).and_return(true)
    allow(bill_company).to receive(:save).and_return(save_result)
    allow(bill_company).to receive(:errors).and_return([])
    allow(BillCompany).to receive(:new).and_return(bill_company)
    allow(JSONAPI::Serializer).to receive(:serialize).with(bill_company)
  end

  describe 'POST create' do
    subject { post :create, params: params }

    context 'when success' do
      it { is_expected.to have_http_status(:ok) }
    end

    context 'when failed' do
      let(:save_result) { false }

      it { is_expected.to have_http_status(:unprocessable_entity) }
    end
  end

  describe 'GET index' do
    let(:bill_companies) do
      [BillCompany.new(id: 1, name: 'test')]
    end

    before do
      allow(BillCompany).to receive(:where).and_return(bill_companies)
      allow(JSONAPI::Serializer).to receive(:serialize).with(bill_companies,
                                                             is_collection: true)
    end

    subject { get :index }

    context 'when success' do
      it { is_expected.to have_http_status(:ok) }
    end
  end

  describe 'PATCH update' do
    subject { patch :update, params: params }

    before do
      allow(bill_company).to receive(:update).and_return(true)
      allow(BillCompany).to receive(:find).and_return(bill_company)
    end

    context 'when success' do
      let(:params) do
        {
          data: {
            type: 'bill-company',
            attributes: {
              name: 'update'
            }
          },
          id: bill_company_id
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
              name: ''
            }
          },
          id: bill_company_id
        }
      end

      before do
        allow(bill_company).to receive(:update).and_return(false)
      end

      it { is_expected.to have_http_status(:unprocessable_entity) }
    end
  end

  describe 'DELETE destroy' do
    subject { delete :destroy, params: params }

    before do
      allow(bill_company).to receive(:update).and_return(true)
      allow(BillCompany).to receive(:find).and_return(bill_company)
    end

    context 'when success' do
      let(:params) do
        {
          data: {
            type: 'bill-company'
          },
          id: bill_company_id
        }
      end

      it { is_expected.to have_http_status(:ok) }
    end

    context 'when failed' do
      let(:params) do
        {
          data: {
            type: 'bill-company'
          },
          id: bill_company_id
        }
      end

      before do
        allow(bill_company).to receive(:update).and_return(false)
      end

      it { is_expected.to have_http_status(:unprocessable_entity) }
    end
  end
end
