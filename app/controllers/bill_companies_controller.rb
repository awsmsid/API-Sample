# frozen_string_literal: true

class BillCompaniesController < ApplicationController
  before_action :verify_api
  before_action :set_bill_company, only: %i[update destroy]

  def create
    bill_company = BillCompany.new(bill_companies_params)

    if bill_company.save
      render json: JSONAPI::Serializer.serialize(bill_company), status: :ok
    else
      render_errors(bill_company)
    end
  end

  def index
    bill_companies = BillCompany.where(is_deleted: false)
    render json: JSONAPI::Serializer.serialize(bill_companies, is_collection: true)
  end

  def update
    if @bill_company.update(bill_companies_params)
      render json: JSONAPI::Serializer.serialize(@bill_company),
             status: :ok
    else
      render_errors(@bill_company)
    end
  end

  def destroy
    if @bill_company.update(is_deleted: true)
      render json: {},
             status: :ok
    else
      render_errors(@bill_company)
    end
  end

  private

  def bill_companies_params
    permitted = %i[name]
    params.require(:data)
          .require(:attributes)
          .permit(permitted)
          .transform_keys(&:underscore)
  end

  def set_bill_company
    @bill_company = BillCompany.find(params[:id])
  end
end
