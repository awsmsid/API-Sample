# frozen_string_literal: true

require 'rails_helper'

describe UtilityTypesController do
  let(:utility_type) { instance_double('utility_type') }
  let(:user_id) { 1 }
  let(:save_result) { true }
  let(:utility_type_id) { 1 }
  let(:params) do
    {
      data: {
        type: 'UtilityType',
        attributes: {
          name: 'test'
        }
      }
    }
  end

  before do
    allow(controller).to receive(:verify_api).and_return(true)
    allow(utility_type).to receive(:[]=).with(:user_id, user_id)
    allow(utility_type).to receive(:valid?).and_return(true)
    allow(utility_type).to receive(:save).and_return(save_result)
    allow(utility_type).to receive(:errors).and_return([])
    allow(UtilityType).to receive(:new).and_return(utility_type)
    allow(JSONAPI::Serializer).to receive(:serialize).with(utility_type)
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
    let(:utility_types) do
      [UtilityType.new(id: 1, name: 'test')]
    end

    before do
      allow(UtilityType).to receive(:where).and_return(utility_types)
      allow(JSONAPI::Serializer).to receive(:serialize).with(utility_types,
                                                             is_collection: true)
    end

    subject { get :index }

    context 'when success' do
      it { is_expected.to have_http_status(:ok) }
    end
  end

  describe 'DELETE destroy' do
    subject { delete :destroy, params: params }

    before do
      allow(utility_type).to receive(:update).and_return(true)
      allow(UtilityType).to receive(:find).and_return(utility_type)
    end

    context 'when success' do
      let(:params) do
        {
          data: {
            type: 'utility-type'
          },
          id: utility_type_id
        }
      end

      it { is_expected.to have_http_status(:ok) }
    end

    context 'when failed' do
      let(:params) do
        {
          data: {
            type: 'utility-type'
          },
          id: utility_type_id
        }
      end

      before do
        allow(utility_type).to receive(:update).and_return(false)
      end

      it { is_expected.to have_http_status(:unprocessable_entity) }
    end
  end

  describe 'PATCH update' do
    subject { patch :update, params: params }

    before do
      allow(utility_type).to receive(:update).and_return(true)
      allow(UtilityType).to receive(:find).and_return(utility_type)
    end

    context 'when success' do
      let(:params) do
        {
          data: {
            type: 'utility-type',
            attributes: {
              name: 'update'
            }
          },
          id: utility_type_id
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
          id: utility_type_id
        }
      end

      before do
        allow(utility_type).to receive(:update).and_return(false)
      end

      it { is_expected.to have_http_status(:unprocessable_entity) }
    end
  end
end
