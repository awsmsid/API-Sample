# frozen_string_literal: true

class BillPaymentInteractor
  def self.create_bill_payment(params, user_id)
    utility_type = UtilityType.find_by_id(params[:utility_type_id])
    company = BillCompany.find_by_id(params[:bill_company_id])
    if utility_type.blank? || company.blank?
      msg = utility_type.blank? ? 'utility_type' : 'company'
      { body: { 'error' => msg + ' does not exist' }, code: 422 }
    else
      save_payment(params, user_id)
    end
  end

  def self.save_payment(params, user_id)
    bill_payment = BillPayment.new(params)
    bill_payment.user_id = user_id
    if bill_payment.save
      { body: JSONAPI::Serializer.serialize(bill_payment), code: 200 }
    else
      { body: { 'error' => bill_payment.errors }, code: 422 }
    end
  end
end
