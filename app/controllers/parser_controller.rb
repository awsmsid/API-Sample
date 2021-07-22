# frozen_string_literal: true

class ParserController < ApplicationController
  before_action :verify_api

  def create
    receipt = StoreParserInteractor.create_and_parse_receipt(parser_params, @user_id)
    response = StoreParserInteractor.response_message_code(receipt)
    render json: response[:body], status: response[:code]
  end

  private

  def parser_params
    params.require(:picture)
  end
end
