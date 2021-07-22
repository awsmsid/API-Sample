# frozen_string_literal: true

class CustomerInteractor
  def self.try_save(customer)
    existing_customer = Customer.find_by_user_id(customer.user_id)
    raise RecordExistError::CustomerExistError if existing_customer
    customer.save
    customer
  end

  def self.try_update(user_id, customer_params)
    customer = Customer.find_by_user_id(user_id)
    raise RecordNotExistError::CustomerDoesNotExistError unless customer
    customer.update(customer_params)
    customer
  end
end
