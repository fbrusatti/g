module CustomersHelper

  def dob(customer)
    customer.dob ? customer.dob.strftime("%d/%m/%Y") : ""
  end
end
