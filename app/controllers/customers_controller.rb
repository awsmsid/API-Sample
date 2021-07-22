# frozen_string_literal: true

class CustomersController < ApplicationController
  before_action :verify_api

  def index
    customers = Customer.all
    render json: JSONAPI::Serializer.serialize(customers, is_collection: true)
  end

  def create
    customer = Customer.new(customer_params)
    customer[:user_id] = @user_id

    customer_save_result = CustomerInteractor.try_save(customer)

    if customer_save_result.errors.empty?
      render json: JSONAPI::Serializer.serialize(customer_save_result),
             status: :ok
    else
      render_errors(customer_save_result)
    end
  end

  def update
    customer = CustomerInteractor.try_update(@user_id, customer_params)

    if customer.errors.empty?
      render json: JSONAPI::Serializer.serialize(customer),
             status: :ok
    else
      render_errors(customer)
    end
  end

  def show
    customer = Customer.find_by_user_id(@user_id)

    render json: JSONAPI::Serializer.serialize(customer),
           status: :ok
  end

  private

  def customer_params
    permitted = %i[full_name dob gender email phone_number website address interests]
    params.require(:data)
          .require(:attributes)
          .permit(permitted)
          .transform_keys(&:underscore)
  end
end
