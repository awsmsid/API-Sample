# frozen_string_literal: true

require 'rails_helper'

describe CustomersController do
  let(:customer) { instance_double('customer', user_id: nil) }
  let(:user_id) { 1 }
  let(:interactor_result) { customer }
  let(:errors) { [] }
  let(:params) do
    {
      data: {
        type: 'Customer',
        attributes: {
          full_name: 'michael febrianto',
          dob: '1986-02-22',
          gender: 'male',
          email: 'michaelfebrianto2@gmail.com',
          phone_number: '0452649226',
          website: 'www.mfebrianto.com',
          address: 'this is my address',
          interests: 'nintendo switch'
        }
      }
    }
  end

  before do
    allow(controller).to receive(:verify_api).and_return(true)
    controller.instance_variable_set(:@user_id, user_id)
    allow(customer).to receive(:[]=).with(:user_id, user_id)
    allow(customer).to receive(:valid?).and_return(true)
    allow(Customer).to receive(:new).and_return(customer)
    allow(interactor_result).to receive(:errors).and_return(errors)
    allow(CustomerInteractor).to receive(:try_save).and_return(interactor_result)
    allow(JSONAPI::Serializer).to receive(:serialize).with(customer)
  end

  describe 'GET index' do
    let(:customers) do
      [Customer.new(id: 1, full_name: 'somebody', dob: '1986-02-22')]
    end

    before do
      allow(controller).to receive(:verify_api).and_return(true)
      allow(Customer).to receive(:all).and_return(customers)
      allow(JSONAPI::Serializer).to receive(:serialize).with(customers, is_collection: true)
    end

    subject { get :index }

    context 'when success' do
      it { is_expected.to have_http_status(:ok) }
    end
  end

  describe 'GET show' do
    let(:customer) do
      Customer.new(id: 1, full_name: 'somebody', dob: '1986-02-22')
    end

    before do
      allow(controller).to receive(:verify_api).and_return(true)
      allow(Customer).to receive(:find_by_user_id).and_return(customer)
      allow(JSONAPI::Serializer).to receive(:serialize).with(customer)
    end

    subject { get :show }

    context 'when success' do
      it { is_expected.to have_http_status(:ok) }
    end
  end

  describe 'POST create' do
    subject { post :create, params: params }

    context 'when success' do
      it { is_expected.to have_http_status(:ok) }
    end

    context 'when failed' do
      let(:errors) { ['there is an error'] }

      it { is_expected.to have_http_status(:unprocessable_entity) }
    end
  end

  describe 'PATCH update' do
    before do
      allow(CustomerInteractor).to receive(:try_update).and_return(interactor_result)
    end

    let(:params) do
      {
        data: {
          type: 'Customer',
          attributes: {
            full_name: 'michael febrianto',
            dob: '1986-02-22',
            gender: 'male',
            email: 'michaelfebrianto2@gmail.com',
            phone_number: '0452649226',
            website: 'www.mfebrianto.com',
            address: 'Changed address',
            interests: 'nintendo switch'
          }
        },
        id: 1
      }
    end

    subject { patch :update, params: params }

    context 'when success' do
      it { is_expected.to have_http_status(200) }
    end

    context 'when failed' do
      let(:errors) { ['there is an error'] }

      it { is_expected.to have_http_status(:unprocessable_entity) }
    end
  end
end
