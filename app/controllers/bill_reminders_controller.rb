# frozen_string_literal: true

class BillRemindersController < ApplicationController
  before_action :verify_api
  before_action :set_bill_reminder, only: %i[update destroy]

  def index
    bill_reminders = BillReminder.where(user_id: @user_id, is_deleted: false)
    render json: JSONAPI::Serializer.serialize(bill_reminders, is_collection: true)
  end

  def create
    bill_reminder = BillReminder.new(bill_reminders_params)
    bill_reminder[:user_id] = @user_id

    if bill_reminder.save
      render json: JSONAPI::Serializer.serialize(bill_reminder),
             status: :ok

    else
      render_errors(bill_reminder)
    end
  end

  def update
    if @bill_reminder.update(bill_reminders_params)
      render json: JSONAPI::Serializer.serialize(@bill_reminder),
             status: :ok
    else
      render_errors(@bill_reminder)
    end
  end

  def destroy
    if @bill_reminder.update(is_deleted: true)
      render json: {},
             status: :ok
    else
      render_errors(@bill_reminder)
    end
  end

  private

  def bill_reminders_params
    permitted = %i[title all_day start_date end_date]
    params.require(:data)
          .require(:attributes)
          .permit(permitted)
          .transform_keys(&:underscore)
  end

  def set_bill_reminder
    @bill_reminder = BillReminder.find(params[:id])
  end
end
