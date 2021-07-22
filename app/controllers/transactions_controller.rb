# frozen_string_literal: true

class TransactionsController < ApplicationController
  before_action :verify_api

  def index
    transactions = Transaction.where(user_id: @user_id)
    render json: JSONAPI::Serializer.serialize(transactions, is_collection: true)
  end
end
