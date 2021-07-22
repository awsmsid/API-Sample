# frozen_string_literal: true

class ReceiptInteractor
  def self.user_history(user_id, order_by, order_type)
    if order_by.present?
      order_value = order_by.tr('-', '_') + ' ' + order_type
      Receipt.where(user_id: user_id, is_deleted: false).order(order_value)
    else
      Receipt.where(user_id: user_id, is_deleted: false).order('created_at desc')
    end
  end

  def self.update_receipt(receipt, store_name, receipt_date, total_paid, address)
    receipt.name = store_name
    receipt.receipt_date = receipt_date
    receipt.total_paid = total_paid
    receipt.address = address
    receipt.status = Receipt.statuses[:complete]
    receipt.mivi_credit = MiviCreditInteractor.credit(total_paid) if receipt.class == Receipt
    receipt.save
    receipt
  end

  def self.update_receipt_status(receipt, receipt_params)
    Rails.logger.info "update_receipt_status : #{receipt_params[:status]}"
    if receipt_params[:status] == 'rejected'
      Rails.logger.info 'rejected'
      receipt.status = Receipt.statuses[:rejected]
      receipt.manual_entry_by = receipt_params[:manual_entry_by]
    elsif receipt_params[:status] == 'complete'
      Rails.logger.info 'complete'
      receipt.status = Receipt.statuses[:complete]
      receipt.name = receipt_params[:name]
      receipt.receipt_date = Time.parse(receipt_params[:receipt_date]).getlocal
      receipt.receipt_items = map_receipt_items(receipt_params[:receipt_items_attributes])
      receipt.mivi_credit = MiviCreditInteractor.credit(receipt_params[:total_paid])
      Rails.logger.info "update mivi credit : #{receipt.mivi_credit}"
      manual_pro = receipt.manual_processing
      manual_pro.update(processed: true)
      Rails.logger.info 'manual process is updated'
      ReceiptProcessingInteractor.update_reward_services(receipt)
    else
      receipt.assign_attributes(receipt_params)
    end
    receipt.save(validate: false)
  end

  def self.map_receipt_items(items)
    item_collection = []
    items.each do |item|
      receipt_item = ReceiptItem.new
      receipt_item.item_name = item[:item_name]
      receipt_item.quantity = item[:quantity]
      receipt_item.price = item[:price]
      item_collection << receipt_item
    end
    item_collection
  end

  def self.receipts_reject(receipt)
    manual_pro = receipt.manual_processing
    if manual_pro.present?
      receipt.status = Receipt.statuses[:rejected]
      if receipt.save(validate: false)
        if manual_pro.update(processed: true)
          { body: JSONAPI::Serializer.serialize(receipt), code: 200 }
        else
          { body: { 'error' => manual_pro.errors }, code: 422 }
        end
      else
        { body: { 'error' => receipt.errors }, code: 422 }
      end
    else
      { body: { 'error' => 'manual_processing doesnot exist' }, code: 422 }
    end
  end
end
