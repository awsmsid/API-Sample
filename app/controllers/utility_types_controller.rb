# frozen_string_literal: true

class UtilityTypesController < ApplicationController
  before_action :verify_api
  before_action :set_utility_type, only: %i[destroy update]

  def create
    utility_type = UtilityType.new(utility_types_params)

    if utility_type.save
      render json: JSONAPI::Serializer.serialize(utility_type), status: :ok
    else
      render_errors(utility_type)
    end
  end

  def index
    utility_types = UtilityType.where(is_deleted: false)
    render json: JSONAPI::Serializer.serialize(utility_types, is_collection: true)
  end

  def destroy
    if @utility_type.update(is_deleted: true)
      render json: {},
             status: :ok
    else
      render_errors(@utility_type)
    end
  end

  def update
    if @utility_type.update(utility_types_params)
      render json: JSONAPI::Serializer.serialize(@utility_type),
             status: :ok
    else
      render_errors(@utility_type)
    end
  end

  private

  def utility_types_params
    permitted = %i[name]
    params.require(:data)
          .require(:attributes)
          .permit(permitted)
          .transform_keys(&:underscore)
  end

  def set_utility_type
    @utility_type = UtilityType.find(params[:id])
  end
end
