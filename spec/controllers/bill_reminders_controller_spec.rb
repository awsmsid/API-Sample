# frozen_string_literal: true

require 'rails_helper'

describe BillRemindersController do
  let(:bill_reminder) { instance_double('bill_reminder', user_id: nil) }
  let(:user_id) { 1 }
  let(:save_result) { true }
  let(:bill_reminder_id) { 1 }
  let(:params) do
    {
      data: {
        type: 'bill-reminders',
        attributes: {
          title: 'bill reminder1',
          all_day: 0,
          start_date: '1o409175049',
          end_date: '1o409175049'
        }
      }
    }
  end

  before do
    allow(controller).to receive(:verify_api).and_return(true)
    controller.instance_variable_set(:@user_id, user_id)
    allow(bill_reminder).to receive(:[]=).with(:user_id, user_id)
    allow(bill_reminder).to receive(:valid?).and_return(true)
    allow(bill_reminder).to receive(:save).and_return(save_result)
    allow(bill_reminder).to receive(:errors).and_return([])
    allow(BillReminder).to receive(:new).and_return(bill_reminder)
    allow(JSONAPI::Serializer).to receive(:serialize).with(bill_reminder)
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

  describe 'PATCH update' do
    FactoryBot.create(:user)
    bill_reminder = FactoryBot.create(:bill_reminder)

    before do
      allow(JSONAPI::Serializer).to receive(:serialize).with(bill_reminder)
    end

    subject { patch :update, params: params }

    context 'when success' do
      let(:params) do
        {
          data: {
            type: 'bill-reminders',
            attributes: {
              title: 'bill reminder update',
              all_day: 0,
              start_date: '1o409175049',
              end_date: '1o409175049'
            }
          },
          id: bill_reminder.id
        }
      end

      it { is_expected.to have_http_status(:ok) }
    end

    context 'when failed' do
      let(:params) do
        {
          data: {
            type: 'bill-reminders',
            attributes: {
              title: '',
              all_day: 0,
              start_date: '1o409175049',
              end_date: '1o409175049'
            }
          },
          id: bill_reminder.id
        }
      end

      it { is_expected.to have_http_status(:unprocessable_entity) }
    end
  end

  describe 'GET index' do
    bill_reminder = [BillReminder.new(id: 1, title: 'Reminder', user_id: 1)]

    before do
      allow(JSONAPI::Serializer).to receive(:serialize).with(bill_reminder,
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
      allow(bill_reminder).to receive(:update).and_return(true)
      allow(BillReminder).to receive(:find).and_return(bill_reminder)
    end

    context 'when success' do
      let(:params) do
        {
          data: {
            type: 'bill-company'
          },
          id: bill_reminder_id
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
          id: bill_reminder_id
        }
      end

      before do
        allow(bill_reminder).to receive(:update).and_return(false)
      end

      it { is_expected.to have_http_status(:unprocessable_entity) }
    end
  end
end
